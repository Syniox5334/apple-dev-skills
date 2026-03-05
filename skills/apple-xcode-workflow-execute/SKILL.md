---
name: apple-xcode-workflow-execute
description: Execute Apple and Swift development workflows with MCP-first routing, official CLI fallback, mutation safety gates, and Dash-local-first documentation policy. Use when tasks involve Xcode MCP operations, build/test/run, toolchain checks, fallback execution via xcodebuild/xcrun/swift/swiftly, or Apple/Swift docs routing.
---

# Apple Xcode Workflow Execute

Use this skill as the canonical execution path for Apple and Swift tasks.

## Intent Classification

Classify requests before running commands:

- session/workspace inspection
- read/search/diagnostics
- build/test/run
- package/toolchain management
- docs lookup
- mutation request

## MCP-First Execution

1. Resolve target workspace/tab through Xcode MCP window metadata.
2. Run supported actions through MCP tools first.
3. On transient timeout/transport failures, retry once.
4. If MCP still fails or capability is missing, continue to official CLI fallback.

Use `references/mcp-tool-matrix.md` for action-to-tool mapping.

## Retry and CLI Fallback

1. Select fallback command from `references/cli-fallback-matrix.md`.
2. Prefer reproducible command blocks with explicit inputs.
3. Prefer `swiftly` toolchain if available; otherwise use Xcode/CLT tooling.
4. If command availability is blocked, provide minimal allowlist guidance.

Use:
- `references/toolchain-management.md`
- `references/allowlist-guidance.md`
- `references/mcp-failure-handoff.md`

## Mutation Safety Gate

Before direct filesystem mutation in Xcode-managed scope, require all safeguards:

1. warn about `.xcodeproj`/`.pbxproj`/`.xcworkspace` risk
2. offer safer MCP or official CLI path
3. offer tooling/setup remediation path
4. obtain explicit opt-in for last-resort direct edits
5. ensure Xcode.app is closed during direct edits

If any step is missing, stop direct mutation fallback.

Use:
- `scripts/detect_xcode_managed_scope.sh`
- `references/mutation-risk-policy.md`
- `references/mutation-via-mcp.md`

## Dash-Local-First Docs Flow

1. Prefer Dash MCP/docsets first.
2. If unavailable or missing coverage, use official Apple/Swift docs.
3. Provide concise setup/install advisory only when cooldown allows.

Use `references/dash-docs-flow.md` and `references/skills-installation.md`.

## Advisory Cooldown Policy

- emit advisory at most once every 21 days
- allow immediate advisory when user explicitly requests reminder
- check cooldown through `scripts/advisory_cooldown.py`

## References

- `references/workflow-policy.md`
- `references/mcp-tool-matrix.md`
- `references/mcp-failure-handoff.md`
- `references/cli-fallback-matrix.md`
- `references/toolchain-management.md`
- `references/allowlist-guidance.md`
- `references/mutation-risk-policy.md`
- `references/mutation-via-mcp.md`
- `references/dash-docs-flow.md`
- `references/skills-installation.md`
- `references/mcp-setup-advisory.md`
- `references/skills-discovery.md`

## Scripts

- `scripts/advisory_cooldown.py`
- `scripts/detect_xcode_managed_scope.sh`

## Interactive Customization Flow

1. Load effective settings:
- `uv run python scripts/customization_config.py effective`

2. Ask targeted questions using `references/customization-flow.md`.

3. Map changes to `SKILL.md`, `references/*`, and scripts.

4. Persist approved overrides:
- `uv run python scripts/customization_config.py apply --input <yaml-file>`

5. Re-check effective settings and summarize active policy:
- `uv run python scripts/customization_config.py effective`
