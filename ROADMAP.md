# Project Roadmap

## Current Milestone
- ID: M10
- Name: Post-Retirement Contract Hardening
- Status: In Progress
- Target Version: v3.1.0
- Last Updated: 2026-03-05
- Summary: Normalize public skill names, straighten workflow roles into primary or guard or fallback or handoff, and align root docs with the renamed four-skill surface.

## Milestones
| ID | Name | Target Version | Status | Target Date | Notes |
| --- | --- | --- | --- | --- | --- |
| M1 | Initial Apple Skill Bundle | v1.0.0 | Completed | 2026-02-27 | Initial four-skill repository baseline. |
| M2 | Portability and Customization Docs | v1.1.x | Completed | 2026-02-27 | Portability cleanup and per-skill customization docs for the original bundle. |
| M3 | Automation Prompt Support | v1.2.0 | Completed | 2026-02-27 | Automation prompt templates added to the original four skills. |
| M4 | Hybrid Apple/Xcode Workflow Suite | v1.3.0 | Completed | 2026-02-28 | Added orchestrator, MCP-first executor, CLI fallback, and safety/docs skills. |
| M5 | Discovery and README Polish | v1.4.x | Completed | 2026-02-28 | README discoverability and link/wording cleanup through `v1.4.2`. |
| M6 | Readiness and Documentation Parity | v1.5.0 | Completed | 2026-03-01 | Roadmap established, docs parity merged, and CI validation guardrails merged. |
| M7 | Claude Code Compatibility Completion | v1.7.0 | Completed | 2026-03-01 | Added grouped nested plugin manifest support. |
| M8 | Canonical Skill v2.0.0 Consolidation | v2.0.0 | Completed | 2026-03-05 | Consolidated the repository around canonical Apple skills and extracted the shared Swift/Apple snippet. |
| M9 | AGENTS Sync Skill Retirement | v3.0.0 | Completed | 2026-03-05 | Removed `apple-swift-package-agents-sync` from the active surface and replaced it with snippet-first guidance plus external docs-alignment recommendations. |
| M10 | Post-Retirement Contract Hardening | v3.1.0 | In Progress | 2026-03-05 | Standardize skill contracts, rename skills for clarity, and straighten workflow roles into primary, guard, fallback, and handoff. |
| M11 | Documentation Maintenance Cadence | v3.1.x | Planned | 2026-03-10 | Add lightweight periodic doc audits and report-refresh guidance for future skill changes. |

## Plan History
### 2026-03-05 - Accepted Plan (M8 -> M9 Transition)
- Scope:
  - Keep `apple-swift-package-bootstrap` deterministic `AGENTS.md` generation.
  - Align bootstrap AGENTS template language with shared `apple-swift-core.md` baseline.
  - Remove `apple-swift-package-agents-sync` and replace routing/docs with explicit migration guidance.
  - Track removal as breaking change for `v3.0.0`.
- Acceptance Criteria:
  - Active skill surface reduced from 5 to 4.
  - README, routing references, and plugin manifest no longer publish sync skill install paths.
  - Migration section explicitly points users to `apple-swift-core.md` snippet and external docs-alignment skills.
  - Validation script passes and stale references are limited to intentional migration notes.
- Risks/Dependencies:
  - Existing users pinned to removed skill name require clear migration notes.
  - Documentation and marketplace index must stay in lockstep to avoid discovery drift.

### 2026-03-05 - Accepted Plan (M10 Documentation Cleanup)
- Scope:
  - Rewrite each active `SKILL.md` to a shared section order.
  - Standardize automation, customization, and handoff contract language.
  - Align root docs and the repository report with the active four-skill surface.
- Acceptance Criteria:
  - Every active `SKILL.md` uses the canonical section order.
  - Every customization knob is labeled `policy-only` or `runtime-enforced`.
  - Root docs no longer describe retired skills as active.
  - Repo-wide docs use one contract vocabulary for inputs, outputs, fallback, and handoff.
- Risks/Dependencies:
  - Root docs, skill docs, and metadata must land together to avoid temporary drift.
  - Public skill identifiers remain stable unless a rename is clearly justified.

### 2026-03-05 - Accepted Plan (M10 Naming-First Workflow Straightening)
- Scope:
  - Rename the public skills to a consistent `apple-<domain>-<purpose>` pattern.
  - Change crossed workflow statuses into `status` plus `path_type`.
  - Recast secondary behavior as guard, fallback, or handoff instead of peer primary workflows.
- Acceptance Criteria:
  - Old skill IDs remain only in migration notes.
  - Every active `SKILL.md` has one numbered primary workflow.
  - Every active skill documents `status` and `path_type`.
  - Router install guidance, Xcode mutation handling, and Dash stage progression are documented in straight non-crossed paths.
- Risks/Dependencies:
  - Renames require root docs, metadata, references, and runtime `SKILL_NAME` constants to land together.
  - Users pinned to old IDs need explicit migration notes.

## Change Log
- 2026-02-28: Initialized roadmap for repository status and next-priority planning.
- 2026-02-28: Closed documentation parity follow-ups and added CI guardrail workflow.
- 2026-03-01: Completed M6 and added M7 for plugin compatibility work.
- 2026-03-05: Started M8 to deliver canonical v2.0.0 naming and consolidation.
- 2026-03-05: Expanded M8 scope to include AGENTS consolidation planning and recorded v3.0.0 sync-skill retirement milestone (M9).
- 2026-03-05: Completed M8 and M9 in the active repository surface.
- 2026-03-05: Started M10 to normalize contracts, handoffs, and policy/runtime wording across active docs.
- 2026-03-05: Expanded M10 to rename public skills for naming consistency and to straighten workflow roles across the active skill surface.
