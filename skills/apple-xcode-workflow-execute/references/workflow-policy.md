# Hybrid Workflow Policy

## Decision order

1. Resolve workspace context.
2. Attempt Xcode MCP path.
3. If MCP path fails, use official CLI fallback immediately.
4. If operation is risky mutation in Xcode-managed scope, apply hard 2-step consent gate.

## MCP-first invariant

Use Xcode MCP tools first for:
- workspace/session inspection
- project discovery and read/search
- diagnostics/build/test actions
- snippet/preview operations
- structured mutation actions supported by MCP

## Automatic fallback invariant

When MCP is unavailable or insufficient:
- do not block waiting for user permission to fallback
- run official command path
- include concise advisory about MCP benefits/setup if advisory cooldown permits

## User-facing advisory requirements

On fallback, include:
- what fallback command was used
- why fallback was necessary
- one-line MCP setup offer

Do not repeat advisories more than once every 21 days unless user asks for reminder.
