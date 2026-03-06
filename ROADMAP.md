# Project Roadmap

## Vision

- Keep `apple-dev-skills` as a small, durable Apple development skill bundle with clear top-level entry points, deterministic local helpers, and maintainer docs that track shipped reality.

## Product principles

- Keep the active public surface constrained to focused top-level skills with clear handoffs.
- Prefer deterministic local scripts and validation over implied workflow behavior.
- Keep installed skills self-contained and compatible with managed, read-only install locations.
- Treat tests, shipped skill assets, and maintainer validation as the source of truth for roadmap updates.

## Milestone Progress

- [x] Milestone 1: Initial Apple Skill Bundle
- [x] Milestone 2: Portability and Customization Docs
- [x] Milestone 3: Automation Prompt Support
- [x] Milestone 4: Hybrid Apple/Xcode Workflow Suite
- [x] Milestone 5: Discovery and README Polish
- [x] Milestone 6: Readiness and Documentation Parity
- [x] Milestone 7: Claude Code Compatibility Completion
- [x] Milestone 8: Canonical Skill v2.0.0 Consolidation
- [x] Milestone 9: AGENTS Sync Skill Retirement
- [x] Milestone 10: Top-Level Skill Reset
- [x] Milestone 11: Documentation Maintenance Cadence
- [ ] Milestone 12: Deferred Audit Reporting and Future Swift Direction

## Milestone 1: Initial Apple Skill Bundle

Scope:

- [x] Establish the initial Apple skill repository and baseline layout.

Tickets:

- [x] Ship the first Apple-focused skill bundle.
- [x] Establish repository-level documentation and validation expectations.

Exit criteria:

- [x] The initial Apple skill bundle exists in a usable published form.

## Milestone 2: Portability and Customization Docs

Scope:

- [x] Improve portability guidance and document customization contracts for the early skill set.

Tickets:

- [x] Document per-skill customization behavior.
- [x] Reduce portability ambiguity in repo and skill docs.

Exit criteria:

- [x] Portability and customization guidance are documented for the shipped skills.

## Milestone 3: Automation Prompt Support

Scope:

- [x] Add automation-oriented prompt references to the skill set.

Tickets:

- [x] Add automation prompt templates to the active skills at the time.

Exit criteria:

- [x] Automation prompt support is available in shipped skill references.

## Milestone 4: Hybrid Apple/Xcode Workflow Suite

Scope:

- [x] Expand the repository into a broader Apple/Xcode workflow suite.

Tickets:

- [x] Add orchestrator-era workflow components and supporting docs.
- [x] Document MCP-first execution, CLI fallback, and safety/docs routing patterns.

Exit criteria:

- [x] The broader Apple/Xcode workflow suite shipped and established the later consolidation baseline.

## Milestone 5: Discovery and README Polish

Scope:

- [x] Improve discoverability and root documentation quality.

Tickets:

- [x] Refine README wording and install guidance.
- [x] Reduce discoverability drift in root docs through follow-up polish.

Exit criteria:

- [x] Root discoverability docs were cleaned up through the `v1.4.x` line.

## Milestone 6: Readiness and Documentation Parity

Scope:

- [x] Establish roadmap tracking and align docs with implementation reality.

Tickets:

- [x] Create and maintain the repository roadmap.
- [x] Add CI-oriented validation guardrails for docs and skills.

Exit criteria:

- [x] Readiness tracking and documentation parity work landed with validation support.

## Milestone 7: Claude Code Compatibility Completion

Scope:

- [x] Complete compatibility work needed for Claude-oriented packaging support.

Tickets:

- [x] Add grouped nested plugin manifest support.

Exit criteria:

- [x] Claude Code compatibility completion work shipped.

## Milestone 8: Canonical Skill v2.0.0 Consolidation

Scope:

- [x] Consolidate the repository around canonical Apple skills and shared baseline guidance.

Tickets:

- [x] Reduce the surface to the canonical Apple skill set for the next release line.
- [x] Extract the shared Swift/Apple baseline snippet for reuse.

Exit criteria:

- [x] Canonical v2.0.0 consolidation shipped with shared snippet guidance in place.

## Milestone 9: AGENTS Sync Skill Retirement

Scope:

- [x] Retire the dedicated AGENTS sync skill and replace it with lighter guidance.

Tickets:

- [x] Remove `apple-swift-package-agents-sync` from the active surface.
- [x] Replace sync guidance with snippet-first and external docs-alignment recommendations.

Exit criteria:

- [x] AGENTS sync responsibilities were removed from the active skill surface without breaking migration clarity.

## Milestone 10: Top-Level Skill Reset

Scope:

- [x] Reset the repository around three parallel top-level skills and straighten the docs contract.

Tickets:

- [x] Remove the router layer from the active surface.
- [x] Restore three independent top-level skills.
- [x] Normalize skill contracts around `status`, `path_type`, fallback, and handoff language.

Exit criteria:

- [x] The active public surface is the current three-skill top-level model.

## Milestone 11: Documentation Maintenance Cadence

Scope:

- [x] Align maintainer docs and validation with the actual shipped repository structure.

Tickets:

- [x] Point root docs at `docs/maintainers/` as the canonical maintainer-doc location.
- [x] Add the durable reality-audit guide.
- [x] Realign repo validation with the canonical maintainer-doc contract.
- [x] Normalize shipped customization-template defaults under each skill's `references/` directory while preserving `~/.config/...` overrides.

Exit criteria:

- [x] Maintainer docs, validation, and shipped skill layout match current repo reality.

## Milestone 12: Deferred Audit Reporting and Future Swift Direction

Scope:

- [ ] Keep future roadmap work explicitly deferred while the current three-skill surface remains stable.

Tickets:

- [ ] Defer recurring maintainer audit/report cadence refinement until it has a clearer operational need.
- [ ] Park follow-up roadmap/reporting cleanup that is not required for the current shipped surface.
- [ ] Hold a placeholder for future non-xcode swift skill design direction.

Exit criteria:

- [ ] A future roadmap update intentionally reactivates this milestone with concrete implementation work and validation criteria.

## Historical Notes

- [x] 2026-02-28: Roadmap tracking began alongside documentation parity and CI validation work.
- [x] 2026-03-01: M6 and M7 completed, closing readiness/parity follow-ups and plugin compatibility work.
- [x] 2026-03-05: M8 through M10 reshaped the repository around canonical naming, router removal, and the three-skill top-level surface.
- [x] 2026-03-06: M11 completed by aligning maintainer docs, repo validation, and shipped customization-template layout with current repo standards.
