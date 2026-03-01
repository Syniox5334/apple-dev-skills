---
name: xcode-mcp-first-executor
description: Execute Apple and Swift tasks through Xcode MCP tools first, with strict workspacePath-based tab resolution and structured fallback handoff when MCP tools are unavailable, time out, or cannot satisfy the operation. Use for MCP-first execution routing or when the user asks to customize this skills MCP retry/handoff policy.
---

# Xcode MCP First Executor

Use this skill when a task can be performed through Xcode MCP.

## Core Rules

- Resolve target workspace by `workspacePath` from `XcodeListWindows`.
- Do not trust stale tab index assumptions.
- Use MCP tools first for supported actions.
- If MCP fails after retry policy, output structured handoff to `$apple-swift-cli-fallback`.

## Workflow

1. Resolve active tab:
- call `XcodeListWindows`
- pick tab by matching `workspacePath`

2. Execute via MCP matrix:
- use `references/mcp-tool-matrix.md`

3. Retry on transient MCP failures:
- one immediate retry for timeout or transport error
- if still failing, generate fallback handoff payload

4. Handoff payload:
- include intent category
- include preferred official CLI command(s)
- include reason MCP path failed

## Mutation Note

For mutation requests in Xcode-managed scope, continue through MCP mutation tools if available. If falling back to direct filesystem edits, route to `$apple-dev-safety-and-docs` first.

## References

- `references/mcp-tool-matrix.md`
- `references/mcp-failure-handoff.md`
- `references/mutation-via-mcp.md`

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
