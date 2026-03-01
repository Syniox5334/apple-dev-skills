# Customization Flow

## Purpose

Tune orchestration routing and guardrail strictness across MCP-first, CLI fallback, and safety/docs handoff.

## Customization Knobs

- `intentBucketsProfile`
- `mcpRetryCount`
- `requireExplicitMutationOptInForFilesystemFallback`
- `docsPolicySkill`
- `advisoryCooldownDays`

## Interactive Question Sequence

1. Ask whether intent categories need to be added or split.
2. Ask for retry threshold before CLI handoff.
3. Ask how strict direct-filesystem fallback should be for mutation tasks.
4. Ask whether docs-policy routing should always invoke `apple-dev-safety-and-docs`.
5. Confirm advisory cooldown and final merged settings before apply.

## File Mapping

- `SKILL.md`: orchestration sequence.
- `references/workflow-policy.md`: routing and handoff policy.
- `references/mcp-setup-advisory.md`: fallback advisory message behavior.
- `references/skills-discovery.md`: downstream skill-routing notes.
- `scripts/advisory_cooldown.py`: advisory timing.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Keep MCP-first priority unless explicitly changed.
- Preserve mutation safety handoff requirements.
- Avoid ambiguous fallback paths.

## Validation Checklist

- Walk through at least one example task per intent bucket.
- Verify retry thresholds are reflected in docs and behavior notes.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Add a dedicated profiling intent bucket."
- "Retry MCP twice before CLI handoff."
- "Never suggest direct filesystem fallback without explicit user request."
