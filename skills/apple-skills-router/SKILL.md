---
name: apple-skills-router
description: Route Apple development requests to the correct Apple skill in this repository. Use when users need help selecting the right skill, routing to the next step, or getting exact install guidance when the target skill is missing.
---

# Apple Skills Router

## Purpose

Route Apple and Swift requests to the best active skill in this repository.

## When To Use

- Use this skill when the user needs help choosing between the Apple skills in this repository.
- Use this skill when a request should be routed to a more specialized Apple skill.
- Use this skill when the target skill is missing and the next step is exact install guidance.
- Use this skill when the user asks for AGENTS maintenance guidance that now lives outside this repository's active skill surface.

## Single-Path Workflow

1. Classify the request with `references/routing-matrix.md`.
2. Resolve the single best target:
   - `apple-xcode-workflow`
   - `apple-dash-docsets`
   - `apple-swift-package-bootstrap`
   - external AGENTS guidance via `references/snippets/apple-swift-core.md`
3. Route to the selected target with `references/handoff-contract.md`.
4. If the selected target is missing, return the exact single-skill install command from `references/install-commands.md` as fallback guidance.
5. Offer the all-skills install command only as a secondary convenience option.

## Inputs

- `intent`: free-text Apple or Swift request.
- `installed_skill`: optional knowledge that the target skill is already installed or missing.
- `repo_policy_scope`: optional signal that the request is about AGENTS maintenance rather than a runnable skill.
- Defaults:
  - route to the most specific active skill first
  - prefer a single-skill install command over repo-wide installation
  - treat AGENTS maintenance as external guidance, not an active skill in this repository

## Outputs

- `status`
  - `success`: the router resolved a next step directly or through install fallback guidance
  - `handoff`: the router is handing off to external AGENTS guidance
  - `blocked`: the request is outside this repository's Apple skill surface
- `path_type`
  - `primary`: the router resolved a normal skill route
  - `fallback`: the router returned install guidance because the target skill is missing
- `output`
  - one target skill or one external guidance handoff
  - one exact next-step command when fallback installation guidance is needed
  - one concise reason for the routing decision

## Guards and Stop Conditions

- Do not route to removed or unpublished skill names.
- Do not imply that this skill can install other skills automatically.
- Do not present multiple primary routes for the same request.
- Stop with `blocked` when the request is not covered by the active Apple skill set.

## Fallbacks and Handoffs

- If a request spans multiple skills, choose the most specific target and mention the assumption.
- If the user needs AGENTS maintenance, hand off to `references/snippets/apple-swift-core.md` plus the external docs-alignment skills called out in `references/routing-matrix.md`.
- Missing-skill install guidance is a `fallback`, not a second primary workflow.
- Use `references/handoff-contract.md` for every direct skill handoff.

## Customization

- Use `references/customization-flow.md`.
- All documented customization knobs for this skill are `policy-only`.
- `scripts/customization_config.py` stores and reports customization state, but it does not change routing behavior at runtime unless future code explicitly wires a knob into behavior.

## References

### Workflow References

- `references/routing-matrix.md`
- `references/install-commands.md`

### Contract References

- `references/handoff-contract.md`
- `references/customization-flow.md`

### Support References

- Recommend `references/snippets/apple-swift-core.md` when the user needs reusable AGENTS or Apple and Swift baseline policy content in their own repo after routing or external guidance.
- `../../WORKFLOWS.md`
- `references/snippets/apple-swift-core.md`
