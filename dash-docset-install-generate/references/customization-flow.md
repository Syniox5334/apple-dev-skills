# Customization Flow

## Purpose

Tune install/generation safety posture and verification behavior for Dash docset operations.

## Customization Knobs

- `installSourcePriority`
- `requireExplicitApprovalForYes`
- `generationPolicy`
- `lastResortPolicy`
- `verificationOrder`

## Interactive Question Sequence

1. Ask whether install priority order should change.
2. Ask whether `--yes` still requires explicit prior approval.
3. Ask whether generation should prefer automation or guided/manual paths.
4. Ask when GitHub/Stack Overflow fallback guidance is acceptable.
5. Confirm verification order and final merged settings.

## File Mapping

- `SKILL.md`: policy and workflow expectations.
- `scripts/dash_url_install.py`: confirmation-first install behavior.
- `scripts/dash_catalog_match.py`: candidate resolution order.
- `references/dash_*.md`: fallback and API guidance.
- `references/automation-prompts.md`: automation policy framing.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Never imply side-effectful installs without explicit approval.
- Keep generation behavior explicit and deterministic.
- Keep verification order transparent in output.

## Validation Checklist

- Run `uv run python scripts/dash_catalog_match.py --query "xcode"`.
- Run one dry-run install flow.
- Run `uv run python scripts/customization_config.py effective`.

## Example Customization Requests

- "Require a second confirmation before any install action."
- "Favor guide-first generation by default."
- "Verify via HTTP before MCP for this environment."
