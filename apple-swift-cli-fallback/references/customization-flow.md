# Customization Flow

## Purpose

Adjust CLI fallback policy and advisory behavior without weakening official-tooling guarantees.

## Customization Knobs

- `fallbackCommandMappingProfile`
- `requireReproducibleCommandBlocks`
- `allowlistGuidanceMode`
- `toolchainPreference`
- `advisoryCooldownDays`

## Interactive Question Sequence

1. Ask which fallback mapping profile should be used for build/test/run intents.
2. Ask whether every fallback response must include a copy/paste-safe command block.
3. Ask whether allowlist guidance should be minimal or expanded with examples.
4. Ask whether toolchain preference should prioritize `swiftly` or Xcode/CLT first.
5. Confirm cooldown days and final merged settings before apply.

## File Mapping

- `SKILL.md`: high-level fallback policy.
- `references/cli-fallback-matrix.md`: command mapping rules.
- `references/toolchain-management.md`: toolchain policy.
- `references/allowlist-guidance.md`: command allowlist guidance.
- `scripts/advisory_cooldown.py`: advisory timing.
- `customization.template.yaml`: default knobs.
- `scripts/customization_config.py`: durable config load/apply/reset.

## Guardrails

- Keep fallback restricted to official Apple and Swift tooling.
- Keep allowlist advice explicit and scoped.
- Keep fallback outcomes reproducible.

## Validation Checklist

- Cross-check `references/cli-fallback-matrix.md` and `SKILL.md` for consistency.
- Run `uv run python scripts/advisory_cooldown.py --show-state`.
- Run `uv run python scripts/customization_config.py effective` and verify expected values.

## Example Customization Requests

- "Prefer xcodebuild fallback for app-style build/test intents."
- "Always include explicit working-directory assumptions in command blocks."
- "Increase advisory cooldown to 30 days."
