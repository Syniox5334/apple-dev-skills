# Router Handoff Contract

Use this payload shape when routing from `apple-skills-router` to another skill or to external AGENTS guidance.

## Inputs

- `intent`: one of `xcode-workflow`, `dash-docsets`, `swift-package-bootstrap`, or `agents-policy`
- `target`: the destination skill name or `external-guidance`
- `reason`: one short sentence explaining the routing decision

## Output

```text
status: <success|handoff|blocked>
path_type: <primary|fallback>
intent: <xcode-workflow|dash-docsets|swift-package-bootstrap|agents-policy>
target: <skill-name|external-guidance>
install_command: <command-or-none>
next_step: <short-text>
```

## Notes

- Use `status: success` with `path_type: primary` for a normal route to another skill.
- Use `status: success` with `path_type: fallback` when the destination skill is missing and install guidance is returned.
- Use `status: handoff` with `path_type: primary` when the destination is external guidance.
- Use `install_command: none` when the destination skill is already available or when the handoff is external guidance.
- Keep the payload short enough to embed directly in a conversational response.
