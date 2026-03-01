---
name: apple-dev-safety-and-docs
description: Enforce mutation safety in Xcode-managed projects and route Apple and Swift documentation through Dash local-first policy with cooldown-gated advisory messaging. Use for risk checks, consent gating, docs fallback decisions, skill-install guidance, or when the user asks to customize this skills safety/docs behavior.
---

# Apple Dev Safety and Docs

Use this skill for risk gating and documentation routing.

## Hard Mutation Gate (Required)

Before direct filesystem mutation in Xcode-managed scope, require all steps:

1. warn user about risks in `.xcodeproj`, `.pbxproj`, `.xcworkspace` contexts
2. offer at least one safer method (Xcode MCP action or official CLI path)
3. offer official-tooling setup/allowlist remediation path
4. get explicit user opt-in for last-resort direct edit
5. ensure Xcode.app is closed while direct edits occur

If any step is missing, do not perform direct mutation fallback.

## Docs Workflow (Dash First)

1. Query Dash MCP/docsets first.
2. If unavailable or missing docset, use official Apple/Swift docs.
3. Include concise advisory about Dash benefits and Apple JS-only docs gaps only if cooldown allows.

## Advisory Cooldown Policy

- emit advisory at most once every 21 days
- if user asks for reminder explicitly, advisory may be shown immediately

## References

- `references/mutation-risk-policy.md`
- `references/dash-docs-flow.md`
- `references/skills-installation.md`

## Scripts

- `scripts/advisory_cooldown.py`
- `scripts/detect_xcode_managed_scope.sh`

## Interactive Customization Flow

1. Load current effective customization settings first:
- `uv run python scripts/customization_config.py effective`

2. Ask targeted customization questions:
- Use `references/customization-flow.md` to drive knob-by-knob questions.
- Confirm desired behavior changes and safety constraints.

3. Map requested changes to implementation files:
- Update `SKILL.md`, `references/*`, and any runtime script files listed in `references/customization-flow.md`.

4. Persist durable customization state:
- Start from `customization.template.yaml` defaults.
- Apply approved overrides with `uv run python scripts/customization_config.py apply --input <yaml-file>`.
- Durable path: `~/.config/gaelic-ghost/apple-dev-skills/<skill-name>/customization.yaml`.
- Optional override root: `APPLE_DEV_SKILLS_CONFIG_HOME`.

5. Report resulting effective configuration:
- Re-run `uv run python scripts/customization_config.py effective` and summarize final active settings.
- If the user asks to remove customization state, run `uv run python scripts/customization_config.py reset`.

Use `references/customization-flow.md` for skill-specific knobs, file mapping, guardrails, validation checks, and example requests.
