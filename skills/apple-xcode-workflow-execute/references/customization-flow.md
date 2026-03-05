# Apple Xcode Workflow Execute Customization Flow

Use this file to customize policy knobs for MCP-first routing, fallback behavior, mutation safety, and docs advisory behavior.

## Knobs

- `intentBucketsProfile`: intent taxonomy profile used in SKILL instructions
- `mcpRetryCount`: retry count for MCP transient failures
- `requireExplicitMutationOptInForFilesystemFallback`: direct-edit opt-in requirement
- `docsRoutingOrder`: preference order for docs sources
- `advisoryCooldownDays`: cooldown window for setup advisories
- `fallbackCommandMappingProfile`: fallback command profile

## File Mapping

- `customization.template.yaml`: defaults
- durable state: `~/.config/gaelic-ghost/apple-dev-skills/apple-xcode-workflow-execute/customization.yaml`
- `SKILL.md`: workflow policy wording
- `references/mcp-tool-matrix.md`: MCP routing detail
- `references/cli-fallback-matrix.md`: fallback command detail
- `references/mutation-risk-policy.md`: mutation safety detail
- `references/dash-docs-flow.md`: docs routing detail
- `scripts/customization_config.py`: durable config load/apply/reset

## Runtime Behavior Note

These knobs are policy defaults stored as customization metadata. Runtime tooling in this skill does not auto-load all knob values unless explicitly wired.

## Validation

1. Run `uv run python scripts/customization_config.py effective`.
2. Confirm settings are reflected in workflow sections.
3. Re-run validation script from repository root.
