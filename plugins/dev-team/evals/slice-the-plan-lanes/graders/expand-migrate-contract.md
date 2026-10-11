---
type: regex
pattern: '\b[Ee]xpand\b[\s\S]*?^(?:#{2,4}[ \t]|\*\*)[^\n]*\b[Mm]igrat[\s\S]*?^(?:#{2,4}[ \t]|\*\*)[^\n]*\b[Mm]igrat[\s\S]*?^(?:#{2,4}[ \t]|\*\*)[^\n]*\b[Cc]ontract\b(?!s)'
flags: m
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

The rename is sequenced as an expand (a lane or part of the contracts step), then at least two migrate lanes (batches), then a contract lane, not one big-bang lane.
