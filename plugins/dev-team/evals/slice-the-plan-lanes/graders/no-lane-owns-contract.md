---
type: regex
pattern: '^[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b[^\n:]{0,25}:(?:(?![.;] )[^\n])*contracts\.ts'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

No lane owns the contract file: the contract change is the architect's contracts step, not a lane.
