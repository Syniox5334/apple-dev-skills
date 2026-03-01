---
name: apple-xcode-hybrid-orchestrator
description: Orchestrate Apple and Swift development workflows with an Xcode MCP-first policy and automatic fallback to official Apple and Swift CLI tooling. Use when tasks involve Xcode, SwiftPM, build/test execution, toolchain checks, docs lookup, mutation-risk decisions, or when the user asks to customize orchestration policy in this skill.
---

# Apple Xcode Hybrid Orchestrator

Use this skill as the entrypoint for Apple and Swift tasks.

## Workflow

1. Classify intent:
- session/workspace
- read/search
- build/test/run
- packaging/toolchain
- docs lookup
- mutation request

2. Route execution:
- Use `$xcode-mcp-first-executor` first for anything supported by Xcode MCP.
- If MCP is unavailable, times out, or lacks needed capability, hand off to `$apple-swift-cli-fallback` immediately.

3. Apply docs policy:
- Use `$apple-dev-safety-and-docs` for Dash local-first docs routing and advisory cooldown handling.

4. Apply mutation safety:
- If request can touch Xcode-managed scope, use `$apple-dev-safety-and-docs` hard 2-step consent gate before any direct filesystem fallback.

## Required Policy

- Always prefer Xcode MCP when it can perform the action.
- Fallback to official tooling automatically when MCP path is blocked.
- On fallback, include concise MCP setup guidance only if cooldown allows.
- Never perform direct mutation in Xcode-managed scope unless safety policy conditions are satisfied.

## References

- `references/workflow-policy.md`
- `references/mcp-setup-advisory.md`
- `references/skills-discovery.md`

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
