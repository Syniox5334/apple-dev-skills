# Agent Skills Workflow Report

## Overview

This report describes the active skills in this repository after the naming-first workflow straightening pass completed on 2026-03-05.

Detailed workflow diagrams, path maps, and Agent ↔ User UX descriptions now live in `WORKFLOWS.md`.

Active skills:

1. `apple-skills-router`
2. `apple-xcode-workflow`
3. `apple-dash-docsets`
4. `apple-swift-package-bootstrap`

Migration map:

| Old ID | New ID |
| --- | --- |
| `apple-skills-router-advise-install` | `apple-skills-router` |
| `apple-xcode-workflow-execute` | `apple-xcode-workflow` |
| `apple-dash-docset-manage` | `apple-dash-docsets` |

## Canonical Path Model

Every active skill now uses the same path vocabulary:

- `primary workflow`: the only numbered top-level path in `SKILL.md`
- `guard`: a condition that must be satisfied before the primary path continues
- `fallback`: a supported secondary path when the primary path cannot run
- `handoff`: a transfer to another skill or later stage
- `blocked`: no valid path remains

Every active skill now documents:

- `status`
- `path_type`
- `output`

Canonical `path_type` values:

- `primary`
- `fallback`

Canonical status policy:

- `success` for completed primary or fallback paths
- `handoff` for directed transfers
- `blocked` when no valid path remains
- `failed` only where an operation can start and then fail mid-run

## Skill Summaries

### `apple-skills-router`

Purpose:

- Route Apple and Swift requests to the best active skill.

Primary workflow:

1. Classify the request.
2. Choose one target.
3. Route to that target.

Straightened behavior:

- Install guidance is now a `fallback`, not a second primary workflow.
- AGENTS guidance is now an external `handoff`, not a peer route target.

Contract notes:

- `status`: `success`, `handoff`, `blocked`
- `path_type`: `primary`, `fallback`
- Handoff contract: `skills/apple-skills-router/references/handoff-contract.md`

### `apple-xcode-workflow`

Purpose:

- Provide the canonical Apple and Swift execution workflow with one MCP-first execution engine.

Primary workflow:

1. Classify the operation.
2. Resolve workspace context.
3. Attempt the MCP path.
4. Retry once for transient failures.
5. Use official CLI fallback when MCP cannot complete.
6. Report the completed path.

Straightened behavior:

- Mutation handling is now a `guard`, not a peer workflow.
- Docs lookup is now an operation profile under the same execution engine, not a separate top-level track.

Contract notes:

- `status`: `success`, `handoff`, `blocked`
- `path_type`: `primary`, `fallback`
- Handoff contract: `skills/apple-xcode-workflow/references/mcp-failure-handoff.md`

### `apple-dash-docsets`

Purpose:

- Manage Dash docsets through a straight stage flow.

Primary workflow:

1. Classify the request into a stage.
2. Start at `search` unless another stage is explicit.
3. Run the selected stage.
4. Hand off forward when needed.
5. Return one status and one path type.

Straightened behavior:

- Default flow is now `search -> install -> generate`.
- `generate` is terminal guidance, not a peer top-level workflow in practice.

Contract notes:

- `status`: `success`, `handoff`, `blocked`
- `path_type`: `primary`, `fallback`
- Handoff contract: `skills/apple-dash-docsets/references/stage-handoff-contract.md`

### `apple-swift-package-bootstrap`

Purpose:

- Create one deterministic Swift package scaffold path grounded in the bundled bootstrap script.

Primary workflow:

1. Collect inputs.
2. Normalize aliases.
3. Run the bundled script.
4. Verify the generated repository.
5. Report the result.

Straightened behavior:

- Manual `swift package init` is fallback-only guidance.
- `tool` remains supported but is documented as an advanced explicit passthrough, not a default branch.

Contract notes:

- `status`: `success`, `blocked`, `failed`
- `path_type`: `primary`, `fallback`

## Repo-Level Alignment

This pass aligned:

- public skill IDs
- directory names
- `SKILL.md` frontmatter names
- install commands
- root docs
- `WORKFLOWS.md`
- handoff references
- `agents/openai.yaml`
- runtime `SKILL_NAME` constants used by customization state

## Follow-Up

The remaining maintenance work is routine:

- keep future skill additions on the `apple-<domain>-<purpose>` naming pattern
- preserve one numbered primary workflow per skill
- keep guards, fallbacks, and handoffs out of peer top-level workflow positions
