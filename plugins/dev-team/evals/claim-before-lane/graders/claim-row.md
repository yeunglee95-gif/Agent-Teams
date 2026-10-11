---
type: regex
pattern: '^\|[^\n]*\bM7\b[^\n]*\|[^\n]*\b20\d\d-\d\d-\d\d\b[^\n]*\|[ \t]*$'
flags: m
target:
  source: file
  path: ROADMAP.md
weight: 2
---

M7's own claim row is on the claim board: a table row that names M7 and a started date.
