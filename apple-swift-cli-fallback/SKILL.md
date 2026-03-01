---
name: apple-swift-cli-fallback
description: Execute automatic fallback through official Apple and Swift CLI tooling when Xcode MCP paths are unavailable or insufficient. Use for xcodebuild, xcrun, SwiftPM, swiftly toolchain workflows, command-availability remediation, or when the user asks to customize this skills fallback behavior.
---

# Apple Swift CLI Fallback

Use this skill when MCP-first execution cannot complete the requested task.

## Core Rules

- Fallback must be automatic and use official tooling.
- Keep fallback commands explicit and reproducible.
- Include concise MCP advisory only if cooldown allows.
- If CLI command is unavailable or blocked, provide `~/.codex/rules` allowlist guidance.

## Workflow

1. Receive handoff from `$xcode-mcp-first-executor` or detect MCP unavailability.
2. Select official command path from `references/cli-fallback-matrix.md`.
3. Execute fallback command.
4. Check advisory cooldown via `scripts/advisory_cooldown.py`.
5. If eligible, include short MCP setup benefit note.
6. If command blocked/missing, provide minimal allowlist and setup actions.

## Toolchain Policy

- Prefer `swiftly` when available.
- Otherwise use official Xcode toolchain and CLT guidance from `references/toolchain-management.md`.

## References

- `references/cli-fallback-matrix.md`
- `references/toolchain-management.md`
- `references/allowlist-guidance.md`

## Scripts

- `scripts/advisory_cooldown.py`

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
