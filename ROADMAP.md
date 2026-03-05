# Project Roadmap

## Current Milestone
- ID: M8
- Name: Canonical Skill v2.0.0 Consolidation
- Status: In Progress
- Target Version: v2.0.0
- Last Updated: 2026-03-05
- Summary: Complete v2 consolidation documentation and start AGENTS strategy consolidation planning: retain bootstrap AGENTS generation, standardize snippet-first guidance, and prepare `apple-swift-package-agents-sync` retirement in v3.0.0.

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
| M8 | Canonical Skill v2.0.0 Consolidation | v2.0.0 | In Progress | 2026-03-05 | Finalize v2 docs and align AGENTS strategy for upcoming sync-skill retirement path. |
| M9 | AGENTS Sync Skill Retirement | v3.0.0 | Planned | 2026-03-06 | Remove `apple-swift-package-agents-sync`, keep bootstrap AGENTS generation, and migrate AGENTS maintenance guidance to snippet + docs-alignment recommendations. |
| M10 | Post-Retirement Contract Hardening | v3.1.0 | Planned | 2026-03-10 | Add output-contract standardization, runtime-vs-policy knob mapping, and handoff observability across active skills. |

## Plan History
### 2026-03-05 - Accepted Plan (v2.0.0 / M8)
- Scope:
  - Consolidate 8 skills into 5 canonical skills.
  - Introduce install-advisor routing skill.
  - Extract shared AGENTS core snippet for reusable standards.
- Acceptance Criteria:
  - Exactly five `SKILL.md` skill directories remain active.
  - Root docs and plugin manifest match new names and paths.
  - Validation script passes with no stale old-skill references in active skill metadata.
- Risks/Dependencies:
  - Breaking rename requires migration guidance for existing users.
  - Merge quality depends on preserving prior safety/fallback behavior.

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

### 2026-03-05 - Accepted Follow-on Backlog (Post-Removal)
- P1:
  - Standardize output contracts across active skills.
  - Add runtime-enforced vs policy-only mapping for customization knobs.
  - Add router decision observability fields for automation logs.
- P2:
  - Standardize cross-skill handoff payload templates.
  - Extend doc validation script with contract/enforcement/handoff checks.
- P3:
  - Add automation examples pack and periodic architecture/report refresh cadence.

## Change Log
- 2026-02-28: Initialized roadmap for repository status and next-priority planning.
- 2026-02-28: Closed documentation parity follow-ups and added CI guardrail workflow.
- 2026-03-01: Completed M6 and added M7 for plugin compatibility work.
- 2026-03-05: Started M8 to deliver canonical v2.0.0 naming and consolidation.
- 2026-03-05: Expanded M8 scope to include AGENTS consolidation planning and recorded v3.0.0 sync-skill retirement milestone (M9).
- 2026-03-05: Added post-removal hardening milestone (M10) for output contracts, knob enforcement clarity, and handoff observability.
