---
type: regex
target: trace
pattern: 'blocked-by:(?=(?:(?!\\n)[^\n]){0,300}?\bM6\b)'
flags: i
weight: 2
---

The overlapping lane is held with a `blocked-by:` line, in the lane notes or the report, that names M6.
