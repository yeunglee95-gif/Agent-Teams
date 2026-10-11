---
type: regex
pattern: '^[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b[^\n:]{0,25}:\**\s*\(?(?:nothing|no files|none)\b'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

Every lane owns files. A step with no files of its own (the final gate) is a step, not a lane.
