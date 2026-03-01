# Automation Prompts

## Automation Fit

- Codex App automation: Strong. Well-suited for recurring drift checks and periodic sync runs.
- Codex CLI automation: Strong. Deterministic script interface with clear check/apply semantics.

## Prerequisites

- Access to target repository root or single repository path.
- Canonical file path available (`assets/AGENTS.md` by default or `<CANONICAL_AGENTS_PATH>` override).
- Permission to write in apply mode.

## Codex App Automation Prompt Template

```text
Use $swift-package-agents-maintainer.

Run a recurring AGENTS.md maintenance workflow with:
- Target root: <TARGET_ROOT>
- Canonical file path: <CANONICAL_AGENTS_PATH>
- Mode: <MODE_CHECK_OR_APPLY>
- Verbose output: <VERBOSE>
- Optional single repo path: <SINGLE_REPO_PATH>

Execution requirements:
1) If `<SINGLE_REPO_PATH>` is set, run single-repo mode with `--repo`.
2) Otherwise run root scan mode with `--root <TARGET_ROOT>`.
3) Apply `<MODE_CHECK_OR_APPLY>`:
   - `check`: include `--check`.
   - `apply`: omit `--check`.
4) Use `--canonical <CANONICAL_AGENTS_PATH>` when provided.
5) Preserve and report the script summary line and exit status.

Output requirements:
- Report scanned/unchanged/drift/updated/mode from script output.
- For check mode, mark run as drift-detected when exit code is non-zero.
- Provide one follow-up action when drift exists.
```

## Codex CLI Automation Prompt Template

```text
Use $swift-package-agents-maintainer for a deterministic non-interactive run.

Task:
Execute `scripts/sync_agents_md.sh` with:
- `<MODE_CHECK_OR_APPLY>` mapped to `--check` or apply mode.
- `--root <TARGET_ROOT>` unless `<SINGLE_REPO_PATH>` is set, then use `--repo <SINGLE_REPO_PATH>`.
- `--canonical <CANONICAL_AGENTS_PATH>` when provided.
- include `--verbose` when `<VERBOSE>` is `true`.

Constraints:
- Do not edit files manually; use script output as source of truth.
- Stop with `blocked` if canonical file is missing.
- Treat `check` mode non-zero exit as drift signal, not command failure.

Return format:
- `status: success|drift-detected|blocked|failed`
- `mode: check|apply`
- `summary_line: scanned=<n> unchanged=<n> drift=<n> updated=<n> mode=<...>`
- `next_step: <text>`
```

## Customization Knobs

- `<TARGET_ROOT>`: Root directory to scan.
- `<CANONICAL_AGENTS_PATH>`: Optional canonical AGENTS.md override.
- `<MODE_CHECK_OR_APPLY>`: `check` or `apply`.
- `<VERBOSE>`: `true` or `false`.
- `<SINGLE_REPO_PATH>`: Optional specific repo path.

## Guardrails and Stop Conditions

- Stop if canonical file does not exist.
- Stop if both root and single-repo inputs are invalid or missing.
- Do not treat drift in check mode as a crash; report it explicitly.
- In apply mode, stop and report permission blockers instead of partial manual edits.

## Expected Output Shape

- One status line mapped from script mode/exit behavior.
- Script summary line preserved exactly.
- Clear next action for drift or blockers.
