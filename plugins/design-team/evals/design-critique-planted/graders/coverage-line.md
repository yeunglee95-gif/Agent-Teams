---
type: regex
pattern: 'Coverage: head [0-9a-f]{7,}'
match: contains
target:
  source: file
  path: reviews/CRITIQUE-M9.md
weight: 1
---

The report ends with the dev team's Coverage line, naming the reviewed head.
