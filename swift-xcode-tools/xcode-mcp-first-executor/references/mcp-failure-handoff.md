# MCP Failure Handoff

Use this payload shape when handing off to `$apple-swift-cli-fallback`.

```text
intent: <build|test|run|package|toolchain|docs|mutation|read-search>
workspace_path: <absolute-path>
tab_identifier: <resolved-or-unknown>
mcp_failure_reason: <timeout|transport|unsupported|precondition>
attempts: <count>
fallback_commands:
  - <official-command-1>
  - <official-command-2>
advisory_eligible: <yes|no>
```

## Retry policy

- Retry once on timeout/transport.
- Do not loop beyond one retry.
- Continue with fallback after second failure.
