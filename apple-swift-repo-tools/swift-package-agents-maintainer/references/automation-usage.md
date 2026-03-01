# Automation Usage

Use this skill in two patterns.

## Drift detection schedule (recommended)

- Run with `--check` on a recurring schedule.
- Example:
  `scripts/sync_agents_md.sh --check --verbose`
- Behavior:
  - Exit `0` when all repos already match canonical `AGENTS.md`.
  - Exit `1` when one or more repos drift from canonical.
- Default discovery root is `~/Workspace`.
- Use `--root` to target a different repository root when needed.
- Discovery excludes hidden directories (`.*`) and common Xcode directories (`*.xcworkspace`, `*.xcodeproj`, `DerivedData`).

## Apply/update schedule

- Run without `--check` when the canonical file changes and you want to roll updates automatically.
- Example:
  `scripts/sync_agents_md.sh --verbose`
- Behavior:
  - Creates missing `AGENTS.md` files.
  - Replaces drifted `AGENTS.md` files with canonical content.
- Default discovery root is `~/Workspace`.
- Use `--root` to target a different repository root when needed.
- Discovery excludes hidden directories (`.*`) and common Xcode directories (`*.xcworkspace`, `*.xcodeproj`, `DerivedData`).

## Single repository runs

- Drift check:
  `scripts/sync_agents_md.sh --repo /path/to/repo --check`
- Apply:
  `scripts/sync_agents_md.sh --repo /path/to/repo`

## Reporting format

The script prints one summary line:

- `scanned=<n> unchanged=<n> drift=<n> updated=<n> mode=<check|apply>`

Use this line directly in automation output.
