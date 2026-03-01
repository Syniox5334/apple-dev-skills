# Automation Prompts

## Automation Fit

- Codex App automation: Strong. Works well for recurring search/report workflows.
- Codex CLI automation: Strong. Works well for deterministic probing and query runs.

## Prerequisites

- Dash installed on macOS.
- If using scripts: `uv` available for `uv run python ...`.
- Dash MCP server available when using MCP-first mode, otherwise local Dash API or URL fallback path.
- Query inputs prepared for placeholders.

## Codex App Automation Prompt Template

```text
Use $dash-docset-search.

Run a Dash discovery/search workflow with:
- Query: <QUERY>
- Docset identifiers: <DOCSET_IDENTIFIERS>
- Max results: <MAX_RESULTS>
- Search snippets: <SEARCH_SNIPPETS>
- FTS policy: <ENABLE_FTS_POLICY>
- Report path: <REPORT_PATH>

Execution order:
1) Prefer Dash MCP tools first.
2) If MCP unavailable, probe local API with `uv run python scripts/dash_api_probe.py`.
3) If API is healthy, use HTTP fallback endpoints.
4) If API is unavailable, provide `dash://` and Service fallback guidance.

Behavior:
- If `<ENABLE_FTS_POLICY>` is `enable-when-disabled`, enable FTS only when status is `disabled`.
- Keep output concise and ranked.
- Write a short report to `<REPORT_PATH>` only when that path is provided.

Output requirements:
- Include selected access path (MCP/API/URL fallback).
- Include top matches and why they were chosen.
- Include any blockers and next action.
```

## Codex CLI Automation Prompt Template

```text
Use $dash-docset-search for a non-interactive CLI run.

Task:
1) Probe Dash access path.
2) Search for `<QUERY>` in `<DOCSET_IDENTIFIERS>` with max `<MAX_RESULTS>` and snippets `<SEARCH_SNIPPETS>`.
3) Apply FTS policy `<ENABLE_FTS_POLICY>`.
4) Produce a machine-readable summary and optional markdown report at `<REPORT_PATH>`.

Constraints:
- Follow fallback order: MCP -> local API -> URL/service guidance.
- Do not perform installs or generation in this workflow.
- Keep recommendations scoped to search/discovery only.

Return format:
- `status: success|partial|blocked|failed`
- `access_path: mcp|http|url_fallback`
- `query: <QUERY>`
- `results_count: <n>`
- `recommended_next_step: <text>`
```

## Customization Knobs

- `<QUERY>`: Search phrase.
- `<DOCSET_IDENTIFIERS>`: Comma-separated identifiers or `all-installed`.
- `<MAX_RESULTS>`: Integer limit.
- `<SEARCH_SNIPPETS>`: `true` or `false`.
- `<ENABLE_FTS_POLICY>`: `never`, `enable-when-disabled`, or `enable-and-retry`.
- `<REPORT_PATH>`: Optional report destination path.

## Guardrails and Stop Conditions

- Stop with `blocked` if neither MCP nor local API nor URL fallback is usable.
- Do not invent docset identifiers; resolve from installed docsets.
- Do not enable FTS when status is `not supported`.
- Do not switch to install behavior; hand off to `$dash-docset-install-generate` when needed.

## Expected Output Shape

- Access-path summary.
- Result list with source and rank.
- FTS actions taken (or skipped) and reason.
- Optional report path confirmation.
