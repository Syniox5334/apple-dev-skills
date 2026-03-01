# Customization Flow

## Purpose

Tune MCP-first execution behavior, retry policy, and structured CLI handoff payload defaults.

## Customization Knobs

- `workspaceResolutionPolicy`
- `mcpToolMappingSource`
- `retryPolicy`
- `handoffPayloadProfile`
- `mutationRoutingPolicy`

## Interactive Question Sequence

1. Ask whether workspace resolution remains `workspacePath`-first.
2. Ask whether MCP tool-mapping reference needs updates.
3. Ask for retry policy changes by error type.
4. Ask for preferred handoff payload shape.
5. Ask how mutation routing should hand off to safety policy and confirm final merged settings.

## File Mapping

- `SKILL.md`: MCP-first and handoff rules.
- `references/mcp-tool-matrix.md`: task-to-tool mapping.
- `references/mcp-failure-handoff.md`: fallback payload structure.
- `references/mutation-via-mcp.md`: mutation routing policy.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Keep MCP-first execution as baseline.
- Keep fallback payload deterministic.
- Keep mutation path aligned with safety dependency skill.

## Validation Checklist

- Validate workspace selection flow against representative `XcodeListWindows` output.
- Validate one transient-failure retry path and one capability-missing path.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Require workspacePath confirmation before build/test actions."
- "Retry timeout errors twice but do not retry capability-missing errors."
- "Always include one preferred and one conservative fallback command."
