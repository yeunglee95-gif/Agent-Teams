---
type: tool_used
tool: Bash
input_match: 'rev-parse'
min: 1
weight: 1
---

The approver reads the branch head with `git rev-parse` before it merges (the head must still be the reviewed head).
