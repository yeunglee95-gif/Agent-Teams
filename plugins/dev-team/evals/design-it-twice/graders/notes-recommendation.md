---
type: regex
pattern: '^#{1,3} [^\n]*\b(?:[Rr]ecommend|[Cc]hos|[Cc]hoice|[Dd]ecision|[Pp]ick|[Ss]elected)'
flags: m
target:
  source: file
  path: plans/M6-design.md
weight: 1
---

The notes end the comparison with a heading that names the recommended design.
