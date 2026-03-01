# Automation Prompts

## Automation Fit

- Codex App automation: Guarded. Install and generation paths can require user confirmation or UI interaction.
- Codex CLI automation: Guarded. Prefer dry-run or plan-first mode in unattended runs.

## Prerequisites

- Dash installed on macOS.
- `uv` available for script-based flows.
- Catalog snapshots present in `references/`.
- Explicit install/generation policy selected before side effects.

## Codex App Automation Prompt Template

```text
Use $dash-docset-install-generate.

This automation is guarded. Default to non-destructive planning unless install approval is explicit.

Inputs:
- Requested docset/topic: <DOCSET_REQUEST>
- Install mode: <INSTALL_MODE>
- Repo name: <REPO_NAME>
- Entry name: <ENTRY_NAME>
- Version: <VERSION>
- Generation policy: <GENERATION_POLICY>

Execution requirements:
1) Resolve candidate with `uv run python scripts/dash_catalog_match.py --query "<DOCSET_REQUEST>"`.
2) If `<INSTALL_MODE>` is `plan-only` or `dry-run`, do not launch install URLs.
3) If `<INSTALL_MODE>` is `approved-install`, use `scripts/dash_url_install.py` and require explicit confirmation semantics.
4) For generation, automate only documented stable paths; otherwise return guided manual steps.
5) Verify post-install via MCP list first, then local API probe/list, then Dash UI confirmation.

Output requirements:
- Return selected candidate, chosen mode, and actions taken.
- Clearly state whether any side-effectful install action was executed.
- Include a safe next action when blocked.
```

## Codex CLI Automation Prompt Template

```text
Use $dash-docset-install-generate for a non-interactive run with guarded behavior.

Task:
1) Match `<DOCSET_REQUEST>` candidates.
2) Execute mode `<INSTALL_MODE>`:
   - `plan-only`: no install launch, recommendation only.
   - `dry-run`: build install URL with `--dry-run`.
   - `approved-install`: perform install path with explicit approval already granted.
3) Apply generation policy `<GENERATION_POLICY>`:
   - automate only stable documented toolchains.
   - otherwise provide guided manual steps.
4) Verify install state with MCP/API fallback order.

Constraints:
- Never perform implicit installs.
- Never use `--yes` unless mode is `approved-install`.
- Stop before side effects when inputs are ambiguous.

Return format:
- `status: success|partial|blocked|failed`
- `mode: <INSTALL_MODE>`
- `candidate: <name/source>`
- `side_effects: none|install-url-launched`
- `verification: mcp|http|ui|not-verified`
- `next_step: <text>`
```

## Customization Knobs

- `<DOCSET_REQUEST>`: Requested docset or topic text.
- `<INSTALL_MODE>`: `plan-only`, `dry-run`, or `approved-install`.
- `<REPO_NAME>`: Dash install repository label.
- `<ENTRY_NAME>`: Dash entry name.
- `<VERSION>`: Optional version pin.
- `<GENERATION_POLICY>`: `guide-first`, `automate-stable`, or `manual-only`.

## Guardrails and Stop Conditions

- Stop if candidate resolution confidence is low and mode is side-effectful.
- Stop if install mode is unclear.
- Stop if verification cannot be completed and report unresolved state.
- Never escalate from `plan-only` or `dry-run` to install without explicit mode change.

## Expected Output Shape

- Clear mode declaration.
- Candidate resolution summary.
- Explicit side-effect statement.
- Verification result and fallback path used.
