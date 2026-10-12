---
type: regex
pattern: '^\|\s*C\d+\s*\|(?:[^|\n]*\|){4}(?!\s*\**(?:behavior|surface)\**\s*\|)[^|\n]*\|[^|\n]*\|\s*$'
flags: mi
match: not_contains
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

Every row's Kind cell (the sixth column) is `behavior` or `surface`.
