# Dash Stage Handoff Contract

Use this payload shape when one Dash stage must hand off to the next stage.

## Inputs

- `from_stage`: `search`, `install`, or `generate`
- `to_stage`: `install` or `generate`
- `reason`: one short explanation of why the handoff is needed

## Output

```text
status: handoff
path_type: primary
from_stage: <search|install|generate>
to_stage: <install|generate>
query_or_request: <short-text>
next_step: <short-text>
```

## Notes

- Use this contract when `search` finds that the requested docset is missing and the next action is installation.
- Use this contract when `install` cannot find a catalog match and the next action is generation guidance.
