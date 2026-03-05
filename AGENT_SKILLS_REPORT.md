# Agent Skills Automation and UX Report

## 1) Overview

This report documents the active canonical skills in this repository and describes:

- automation use-cases
- end-to-end workflow behavior
- user-facing UI/UX paths
- fallback and failure handling
- output contracts and policy knobs

In-scope skills:

1. `apple-skills-router-advise-install`
2. `apple-xcode-workflow-execute`
3. `apple-dash-docset-manage`
4. `apple-swift-package-bootstrap`

Primary source files:

- `README.md`
- `AGENTS.md`
- `skills/*/SKILL.md`
- `skills/*/references/automation-prompts.md`
- Skill-specific workflow references in each `skills/*/references/` directory

## 2) Methodology and Scope

### Methodology

1. Extracted each skill's declared purpose and workflow from `SKILL.md`.
2. Normalized automation intent into four categories:
- recurring check/reporting
- one-off execution
- guarded mutation/apply
- install/advisory routing
3. Derived user journeys from reference policy and prompt templates.
4. Mapped each journey into standard states:
- `Entry`, `Classify`, `Validate`, `Execute`, `Fallback`, `Report`, `Handoff`
5. Captured output contracts and stop conditions from templates and policy docs.

### Scope

- Repository-local skills only (no external repos or runtime telemetry).
- Current documentation and scripts only (no speculative future behavior).
- UX path modeling for Codex App and Codex CLI interaction styles.

### Out of Scope

- Benchmarking runtime performance of scripts/tools.
- Editing skill logic or scripts.
- Verifying external tool availability on a specific host at runtime.

## 3) Cross-Skill System Model

### Interaction model

1. User enters task intent (chat, automation prompt, or CLI instruction).
2. Router skill (explicitly or implicitly) maps intent to a specialized skill.
3. Specialized skill applies policy gates and prerequisites.
4. Skill executes primary path; falls back using deterministic policy.
5. Skill returns concise structured outcomes with next-step guidance.

### Core UX patterns across all skills

- Deterministic command patterns over ad hoc behavior.
- Explicit approval gating for risky or side-effectful actions.
- Fallback path clarity (what changed, why, what to do next).
- Machine-readable or compact summary lines for automation consumers.

### Shared risk controls

- Do not assume install consent for side-effectful operations.
- Stop with `blocked` for missing prerequisites or inaccessible execution paths.
- Keep mutation scope bounded and explicit.

## 4) Skill Sections

## Skill: `apple-skills-router-advise-install`

### 1. Purpose and Trigger Conditions

Routes Apple/Swift requests to the correct skill and provides exact install commands when a required skill is missing.

Trigger classes:

- Xcode/Swift execution, diagnostics, build/test/run
- Dash docset search/install/generation
- Swift package bootstrap
- AGENTS maintenance routing to snippet + docs-alignment recommendations

### 2. Automation Use-Cases

- One-off request triage in conversational sessions.
- Install advisory response when dependency skill is absent.
- Friction-reducing pack suggestions for common combinations.

Automation category mapping:

- recurring check/reporting: low
- one-off execution: high
- guarded mutation/apply: n/a
- install/advisory routing: high

### 3. End-to-End Workflow

1. Parse user intent against routing matrix.
2. Resolve target skill.
3. If skill exists, route directly.
4. If missing, emit copy-paste install command.
5. Optionally include pack-level install commands.

### 4. Journey Table + State Paths

| Step | User Action | System/Skill Action | Decision Rule | Output | Failure Path | Notes |
|---|---|---|---|---|---|---|
| Entry | Ask for Apple dev help | Ingest task text | Any Apple/Swift domain phrase | Task captured | None | Works in App/CLI chats |
| Classify | Provide problem details | Match against routing matrix | Best semantic match | Chosen target skill | Ambiguous intent -> prefer default routing preference | Uses `references/routing-matrix.md` |
| Validate | Ask for execution/install help | Check whether skill is available | Skill present or missing | Route or install advice | Missing skill -> install command emitted | No runtime install API assumptions |
| Execute | Accept routing advice | Produce command guidance | Missing skill only | `npx skills add ... --skill <name>` | Invalid repo or typo risk | Uses fixed repo `gaelic-ghost/apple-dev-skills` |
| Fallback | Need broader setup | Offer pack or `--all` options | User friction reduction | Pack install commands | None | Pack suggestions are explicit |
| Report | Confirm next step | Return concise recommendation | Single best path prioritized | Actionable command set | None | No hidden side effects |
| Handoff | Continue execution | Transfer to target skill | Skill installed or present | Skill-level workflow begins | If unresolved intent, ask for clarifier | Router stops after handoff |

### 5. Guardrails and Approval Gates

- No claim of implicit installation APIs.
- Commands must be explicit and copy-paste ready.
- Route only to known skill names in the repository.

### 6. Fallback and Failure Modes

- Ambiguous intent: apply routing preference and clarify if needed.
- Missing skill: install advisory path.
- Unknown request outside matrix: provide closest supported skill and boundary note.

### 7. Expected Output Contracts

- Direct route target or install command(s).
- Optional pack-level alternatives.
- Minimal verbose framing.

### 8. Customization and Policy Knobs

- `defaultRoutingPreference`
- `preferPackSuggestions`
- `installCommandStyle`
- `includeAllOption`

Runtime note: current behavior is policy-driven via docs, not dynamic script branching.

### 9. Operational Readiness

- Prereqs: none beyond `npx skills` path for install guidance.
- Reliability: high (text-only deterministic mapping).
- Observability: recommendation correctness validated by install command format checks.

Review checkpoint:

- Verify every route maps to one of the active canonical skills and no stale names remain.

---

## Skill: `apple-xcode-workflow-execute`

### 1. Purpose and Trigger Conditions

Canonical execution workflow for Apple/Swift tasks with MCP-first policy, one-retry fallback behavior, mutation safety gate, and Dash-local-first docs routing.

Trigger classes:

- workspace/session inspection
- read/search/diagnostics
- build/test/run
- package/toolchain management
- docs lookup
- mutation request

### 2. Automation Use-Cases

- One-off interactive execution with controlled fallbacks.
- Semi-automated deterministic command execution in constrained environments.
- Policy-backed mutation handling in Xcode-managed scope.

Automation category mapping:

- recurring check/reporting: medium (policy checks/advisories)
- one-off execution: high
- guarded mutation/apply: high
- install/advisory routing: medium

### 3. End-to-End Workflow

1. Classify intent.
2. Resolve Xcode workspace/tab context.
3. Attempt MCP tool path first.
4. On timeout/transport failure, retry once.
5. If unavailable/unsupported, run official CLI fallback immediately.
6. If risky direct mutation considered in managed scope, enforce hard consent gate.
7. For docs, prefer Dash local path, then official Apple/Swift docs.
8. Emit cooldown-gated MCP setup advisory when fallback occurred.

### 4. Journey Table + State Paths

| Step | User Action | System/Skill Action | Decision Rule | Output | Failure Path | Notes |
|---|---|---|---|---|---|---|
| Entry | Request Xcode/Swift operation | Parse intent bucket | Bucket in known taxonomy | Routed intent class | Unknown intent -> closest class | Intent buckets defined in `SKILL.md` |
| Classify | Provide workspace/task context | Resolve tab/workspace metadata | MCP supports path and tool exists | MCP action selected | Missing preconditions | Uses MCP tool matrix |
| Validate | Confirm operation | Apply capability/risk checks | Mutation in managed scope? | Safe path or gate path | Missing prerequisites | Managed scope via `.xcodeproj/.xcworkspace/.pbxproj` |
| Execute | Proceed | Run MCP tool | MCP success | Result returned | Timeout/transport/unsupported | One retry on transient failures |
| Fallback | MCP failed | Run official CLI command | Second MCP attempt failed or unsupported | CLI output and reason | Command blocked by allowlist/sandbox | No user pre-approval needed for fallback invariant |
| Report | Review response | Include command, reason, setup offer | Fallback occurred + advisory eligible | Concise fallback report | Advisory suppressed by cooldown | Cooldown default 21 days |
| Handoff | Need docs/install help | Route to Dash/manage skill guidance | Request is docset install/search escalation | Cross-skill instruction | None | Handoff targets explicitly documented |

### 5. Guardrails and Approval Gates

- Mutation safety gate for direct filesystem edits in Xcode-managed scope requires:
1. explicit risk warning
2. safer alternative offered
3. setup/remediation path offered
4. explicit user opt-in
5. Xcode.app closed during edit
- If any requirement missing, stop direct mutation fallback.

### 6. Fallback and Failure Modes

- MCP timeout/transport: one retry then fallback.
- MCP unsupported: immediate official CLI fallback.
- CLI blocked by policy: provide narrow allowlist guidance.
- Dash unavailable: use official docs and advisory path.

### 7. Expected Output Contracts

On fallback, response includes:

- command used
- reason fallback was necessary
- one-line MCP setup offer (cooldown-gated)

Handoff payload pattern includes:

- `intent`, `workspace_path`, `tab_identifier`
- `mcp_failure_reason`, `attempts`
- `fallback_commands`, `advisory_eligible`

### 8. Customization and Policy Knobs

- `intentBucketsProfile`
- `mcpRetryCount`
- `requireExplicitMutationOptInForFilesystemFallback`
- `docsRoutingOrder`
- `advisoryCooldownDays`
- `fallbackCommandMappingProfile`

Runtime note: knobs are policy defaults unless explicitly wired into scripts/tools.

### 9. Operational Readiness

- Prereqs: Xcode MCP tool availability for primary path; official Apple CLI tooling for fallback.
- Reliability: high due to deterministic retry+fallback invariant.
- Observability: fallback message requirements and advisory cooldown behavior provide auditability.

Review checkpoint:

- Verify fallback messaging always includes command, reason, and advisory decision.

---

## Skill: `apple-dash-docset-manage`

### 1. Purpose and Trigger Conditions

Unified Dash workflow for docset search, install, and generation with deterministic fallback order across MCP, HTTP API, and URL/service paths.

Trigger classes:

- docset discovery/search
- FTS enablement policy
- install path guidance and execution (with approval)
- docset generation guidance

### 2. Automation Use-Cases

- Recurring search/report workflows.
- Non-interactive probing + search runs (CLI strong fit).
- Guarded install/generation workflows with explicit approval.

Automation category mapping:

- recurring check/reporting: high
- one-off execution: high
- guarded mutation/apply: medium (install/generation)
- install/advisory routing: medium

### 3. End-to-End Workflow

1. Prefer Dash MCP tools.
2. If unavailable, probe local Dash HTTP API.
3. If API unavailable, provide URL scheme/System Service fallback.
4. Return ranked results with chosen access path and blockers.
5. For install/generation, require explicit user approval before side effects.

### 4. Journey Table + State Paths

| Step | User Action | System/Skill Action | Decision Rule | Output | Failure Path | Notes |
|---|---|---|---|---|---|---|
| Entry | Ask to find docs/docsets | Capture query and targets | Query + optional docset IDs present | Search task initialized | Missing query -> request details | Works for App and CLI templates |
| Classify | Indicate search/install/generate intent | Route to matching subflow | Intent = discovery vs install/generate | Selected subflow | Mixed intent -> keep search side-effect free | Separation is explicit |
| Validate | Provide constraints | Resolve access path health | MCP available? else HTTP? else URL | Access path chosen | No usable path -> blocked | Fallback order is fixed |
| Execute | Run search | Query docsets and optional FTS policy | FTS status supports enable? | Ranked results | Invalid identifiers/no docsets | Uses MCP/API interfaces |
| Fallback | Primary path unavailable | Switch path MCP->HTTP->URL/service | Next path healthy | Continued workflow | All paths unavailable | Report exact failed path |
| Report | Request summary/report | Emit concise result bundle | Output format requirements met | top matches + path + next step | partial/blocked status | Supports optional report file path |
| Handoff | Need install/generation | Route to guarded install/generate flow | Side effects requested | approval-gated next steps | no approval -> stop | Confirmation-first behavior |

### 5. Guardrails and Approval Gates

- Explicit approval required before install actions.
- Do not perform install/generation during search-only workflows.
- Do not invent docset identifiers.
- Do not enable FTS when status is `not supported`.

### 6. Fallback and Failure Modes

- MCP unavailable: HTTP fallback.
- HTTP unavailable/stale status port: URL/service fallback.
- No path available: `blocked`.
- Trial/purchase/API restrictions: report and suggest next action.

### 7. Expected Output Contracts

Expected machine-readable fields (CLI template):

- `status: success|partial|blocked|failed`
- `access_path: mcp|http|url_fallback`
- `query`
- `results_count`
- `recommended_next_step`

Human summary includes:

- access path used
- top matches + rationale
- blockers + follow-up action

### 8. Customization and Policy Knobs

- `fallbackOrder`
- `defaultMaxResults`
- `defaultSearchSnippets`
- `installSourcePriority`
- `requireExplicitApprovalForYes`
- `generationPolicy`
- `troubleshootingPreference`

Runtime note: knobs are policy metadata unless explicitly wired in scripts.

### 9. Operational Readiness

- Prereqs: Dash on macOS; MCP server or local API for richer paths; `uv` for script workflows.
- Reliability: high for search/reporting, guarded for install/generation.
- Observability: explicit access-path and status fields support automation diagnostics.

Review checkpoint:

- Verify every reported search includes access path and reasoned ranking.

---

## Skill: `apple-swift-package-bootstrap`

### 1. Purpose and Trigger Conditions

Deterministic scaffold workflow for new Swift packages (library/executable/tool), with platform/version defaults, AGENTS template copy, git init, and optional validation.

Trigger classes:

- one-off package creation
- standardized team bootstrap workflows
- optional automation runs with strict placeholders

### 2. Automation Use-Cases

- Non-interactive deterministic CLI scaffolding.
- Guarded app automation for explicit user-requested scaffolds.
- Team baseline generation with built-in validation.

Automation category mapping:

- recurring check/reporting: low
- one-off execution: high
- guarded mutation/apply: high
- install/advisory routing: low

### 3. End-to-End Workflow

1. Confirm required inputs (`name`, `type`, destination, platform preset, version profile).
2. Run `scripts/bootstrap_swift_package.sh` with explicit flags.
3. Refuse overwrite of non-empty destination.
4. Validate structure and run `swift build` + `swift test` unless skipped.
5. Return concise status and command used.

### 4. Journey Table + State Paths

| Step | User Action | System/Skill Action | Decision Rule | Output | Failure Path | Notes |
|---|---|---|---|---|---|---|
| Entry | Request new Swift package | Capture scaffold parameters | Required placeholders present | Parameter set formed | Missing inputs -> prompt fill-in | Aliases accepted for platform/version |
| Classify | State package intent | Map to type/profile defaults | Type unspecified -> `library`; profile unspecified -> `current-minus-one` | Final config | Conflicting inputs | Uses `package-types.md` guidance |
| Validate | Approve destination | Check prerequisites and target dir state | `swift`, `git`, assets present; target empty | Ready to execute | Missing tool/assets/non-empty dir | No destructive overwrite |
| Execute | Confirm run | Invoke bootstrap script | Script success | Scaffold created | Script fails | Keeps scope to target package path |
| Fallback | Script unavailable/fails | Manual bootstrap path with documented steps | Fallback allowed and explicit | Package initialized manually | Missing core tools | Includes AGENTS copy and git init |
| Report | Ask for result | Emit summary with command + checks | Validation enabled? | status/path/checks/notes | build/test fail -> blocked/failed | Output is concise and structured |
| Handoff | Continue development | Transition to package coding/testing | Bootstrap success | Next-step guidance | None | Suggest immediate development workflow |

### 5. Guardrails and Approval Gates

- Do not overwrite non-empty destination directories.
- Stop on missing `swift`, `git`, or `assets/AGENTS.md`.
- Do not continue after failed validation unless `--skip-validation` is explicitly set.
- Keep modifications scoped to destination package path.

### 6. Fallback and Failure Modes

- Missing prerequisites: stop with actionable blocker.
- Validation failures in constrained env: allow explicit `--skip-validation` rerun.
- Script failure: surface exact step and required remediation.

### 7. Expected Output Contracts

Expected return shape (CLI template):

- `status: success|blocked|failed`
- `path`
- `checks`
- `notes`

Human summary includes:

- created path
- package type/platform/version profile
- validation status
- exact command used

### 8. Customization and Policy Knobs

- `defaultPackageType`
- `defaultPlatformPreset`
- `defaultVersionProfile`
- `initializeGit`
- `copyAgentsMd`
- `namingPattern`

Runtime note: customization defaults are metadata unless explicitly wired in script behavior.

### 9. Operational Readiness

- Prereqs: `swift`, `git`, writable destination, script and template assets present.
- Reliability: high for deterministic one-off runs.
- Observability: summary output and validation checks provide clear state.

Review checkpoint:

- Verify generated repo contains `Package.swift`, `AGENTS.md`, `.git`, and `Tests/`.

## 5) Comparative Matrix

| Skill | App Automation Fit | CLI Automation Fit | Interactivity Level | Approval Requirements | Failure Recovery Strategy | Output Strictness |
|---|---|---|---|---|---|---|
| `apple-skills-router-advise-install` | Medium | Medium | Low-medium | None for routing; install is advisory only | Route to closest supported skill and emit install command | Medium |
| `apple-xcode-workflow-execute` | Strong for interactive execution | Strong for deterministic fallback execution | Medium-high | Explicit consent required for last-resort direct filesystem edits in managed scope | MCP retry once -> official CLI fallback -> allowlist guidance if blocked | High |
| `apple-dash-docset-manage` | Strong for search/report; guarded for install/generation | Strong for search/probe; guarded for install/generation | Medium | Explicit approval for install actions | MCP -> HTTP API -> URL/service fallback; blocked if all unavailable | High |
| `apple-swift-package-bootstrap` | Guarded for one-off scaffold | Strong for deterministic scaffold | Medium | Guarded by prerequisite and non-overwrite gates; explicit skip-validation required to bypass checks | Stop on blockers; optional explicit skip-validation path | High |

## 6) Implementation Gaps and Recommendations

### Gap 1: Policy knobs vs runtime enforcement

Observed across multiple skills: customization knobs are stored as policy metadata but are not always auto-wired into runtime scripts.

Recommendation:

1. Add a per-skill "runtime wired knobs" table.
2. Mark each knob as `policy-only` or `runtime-enforced`.
3. Add validation checks that fail when docs imply enforcement that does not exist.

### Gap 2: Uneven machine-readable output contracts

Some skills have explicit structured return contracts, others rely on narrative response conventions.

Recommendation:

1. Standardize output contract fields for all skills:
- `status`
- `mode`
- `path_or_scope`
- `summary`
- `next_step`
2. Add one canonical `references/output-contracts.md` per skill.

### Gap 3: Router observability

Router guidance is clear, but there is no explicit recommendation for logging route decisions in automation contexts.

Recommendation:

1. Add optional route decision output:
- `intent_class`
- `selected_skill`
- `reason`
2. Provide an automation-friendly minimal JSON example in router references.

### Gap 4: Cross-skill handoff contract standardization

`apple-xcode-workflow-execute` defines payload shape for failure handoff, but this pattern is not mirrored across other handoff points.

Recommendation:

1. Define shared handoff schema conventions.
2. Add minimal handoff templates for router -> target and dash search -> install flows.

## 7) Appendix

### A) Command Templates

Router install:

```bash
npx skills add gaelic-ghost/apple-dev-skills --skill <skill-name>
```

Swift bootstrap:

```bash
scripts/bootstrap_swift_package.sh \
  --name <Name> \
  --type <library|executable|tool> \
  --destination <dir> \
  --platform <mac|mobile|multiplatform> \
  --version-profile <latest-major|current-minus-one|current-minus-two>
```

Dash probe:

```bash
uv run python scripts/dash_api_probe.py
```

Xcode fallback examples:

```bash
xcodebuild -workspace <ws.xcworkspace> -scheme <scheme> build
swift test
xcrun --find swift
```

### B) Output Contract Snippets

Dash CLI template output:

```text
status: success|partial|blocked|failed
access_path: mcp|http|url_fallback
query: <QUERY>
results_count: <n>
recommended_next_step: <text>
```

Bootstrap output:

```text
status: success|blocked|failed
path: <resolved path>
checks: <passed checks>
notes: <brief follow-up>
```

### C) Glossary

- MCP: Model Context Protocol tool path.
- CLI fallback: official Apple/Swift command path when MCP cannot serve request.
- Managed scope: project context containing `.xcodeproj`, `.xcworkspace`, or `.pbxproj`.
- Drift: repo `AGENTS.md` differs from canonical content.
- Guarded workflow: operation requiring explicit constraints/approval before side effects.
