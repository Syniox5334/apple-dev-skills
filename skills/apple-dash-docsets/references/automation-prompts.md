# Dash Automation Contract

## Purpose

Provide one consistent automation contract for Dash `search`, `install`, and `generate` stages.

## Inputs

- `stage`
- `query`
- `docset_identifiers`
- `max_results`
- `search_snippets`
- `enable_fts_policy`
- `report_path`

## Constraints

- Dash must be installed on macOS.
- Use Dash MCP first when available.
- Do not perform installs inside a `search` automation run.
- Do not enable FTS when the docset reports `not supported`.
- Use installed docset identifiers only.

## Status Values

- `success`
- `blocked`
- `handoff`

## Output

- `status`
- `path_type`
- `stage`
- `access_path` or `source_path`
- concise result summary
- one next step when follow-up is needed

## Codex App Prompt Template

```text
Use $apple-dash-docsets.

Run Dash stage `<STAGE>` with:
- Query or request: <QUERY>
- Docset identifiers: <DOCSET_IDENTIFIERS>
- Max results: <MAX_RESULTS>
- Search snippets: <SEARCH_SNIPPETS>
- FTS policy: <ENABLE_FTS_POLICY>
- Report path: <REPORT_PATH>

Execution order:
1) Classify the request into one stage: `search`, `install`, or `generate`.
2) If no stage is explicit, start with `search`.
3) Use the stage's documented primary path.
4) Use the stage's documented fallback order only if the primary path is unavailable.
5) When the next action belongs to the next stage, return a `handoff` output instead of mixing workflows.

Behavior:
- If `<STAGE>` is `search`, follow `mcp -> http -> url-service`.
- If `<STAGE>` is `install`, follow `built-in -> user-contributed -> cheatsheet`.
- If `<STAGE>` is `generate`, use stable automation first and manual guidance only as fallback.
- If `<ENABLE_FTS_POLICY>` is `enable-when-disabled`, enable FTS only when status is `disabled`.
- Write a short report to `<REPORT_PATH>` only when that path is provided.
- Keep the response aligned to the documented `status`, `path_type`, and `output` contract.
```

## Codex CLI Prompt Template

```text
Use $apple-dash-docsets for a non-interactive CLI run.

Task:
1) Run Dash stage `<STAGE>`.
2) Use `<QUERY>` or `<DOCSET_REQUEST>` as the stage input.
3) Follow the stage's documented primary path and fallback order.
4) Produce a machine-readable summary and optional markdown report at `<REPORT_PATH>`.

Constraints:
- Keep the run scoped to the requested stage.
- Use `handoff` instead of crossing into another primary workflow.
- Keep recommendations deterministic and concise.

Return contract:
- `status: success|blocked|handoff`
- `path_type: <primary|fallback>`
- `stage: <STAGE>`
- `access_path_or_source_path: <value>`
- `next_step: <text>`
```

## Customization Knobs

- `<STAGE>`: `search`, `install`, or `generate`.
- `<QUERY>`: Search phrase or short docset request.
- `<DOCSET_IDENTIFIERS>`: Comma-separated identifiers or `all-installed`.
- `<MAX_RESULTS>`: Integer limit for `search`.
- `<SEARCH_SNIPPETS>`: `true` or `false` for `search`.
- `<ENABLE_FTS_POLICY>`: `never`, `enable-when-disabled`, or `enable-and-retry`.
- `<REPORT_PATH>`: Optional report destination path.

## Guardrails and Stop Conditions

- Stop with `blocked` if the selected stage has no usable primary path or fallback path.
- Do not invent docset identifiers; resolve from installed docsets.
- Do not enable FTS when a docset reports `not supported`.
- Do not cross from `search` into `install` or from `install` into `generate` without returning `status: handoff`.
