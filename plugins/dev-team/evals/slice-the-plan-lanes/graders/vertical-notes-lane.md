---
type: regex
pattern: '^(?=[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b)(?=[^\n]*db/notes)(?=[^\n]*api/notes)(?=[^\n]*ui/)'
flags: m
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

At least one notes lane is a vertical slice: its owned files cover the data, API and screen layers together.
