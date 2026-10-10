---
type: tool_order
before:
  tool: Bash
  input_match: 'python3|unittest'
after:
  tool: Edit
  input_match: 'src/bill\.py'
weight: 2
---

A command that runs the code is run before the source file is edited.
