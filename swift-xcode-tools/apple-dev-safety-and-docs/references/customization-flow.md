# Customization Flow

## Purpose

Tune mutation safety and docs-routing behavior for local policies while preserving hard safety defaults.

## Customization Knobs

- `mutationScopePatterns`
- `requireExplicitTypedConfirmation`
- `docsRoutingOrder`
- `advisoryCooldownDays`
- `missingDocsetMessageMode`

## Interactive Question Sequence

1. Ask whether the user wants stricter or looser mutation safeguards.
2. Ask whether docs routing should stay Dash-first or prefer immediate official-web fallback.
3. Ask for desired advisory cooldown duration in days.
4. Confirm whether missing docsets should show install guidance or direct fallback behavior.
5. Confirm final effective settings before applying.

## File Mapping

- `SKILL.md`: policy wording and workflow sequence.
- `references/mutation-risk-policy.md`: mutation decision criteria.
- `references/dash-docs-flow.md`: docs routing details.
- `scripts/detect_xcode_managed_scope.sh`: scope-detection logic.
- `scripts/advisory_cooldown.py`: cooldown behavior.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Keep hard mutation gate intact before direct filesystem edits.
- Do not bypass explicit opt-in for risky direct edits.
- Keep docs routing deterministic and documented.

## Validation Checklist

- Run `scripts/detect_xcode_managed_scope.sh` with representative paths.
- Run `uv run python scripts/advisory_cooldown.py --show-state` and check cooldown behavior.
- Run `uv run python scripts/customization_config.py effective` and confirm expected merged settings.

## Example Customization Requests

- "Require explicit typed confirmation for every direct-edit fallback."
- "Use official Apple docs immediately when a Dash docset is missing."
- "Set advisory cooldown to 14 days."
