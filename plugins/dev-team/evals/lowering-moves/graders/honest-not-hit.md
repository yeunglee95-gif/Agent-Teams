---
type: regex
pattern: '^(?![^\n]*\b(?:not a hit|not hits?|no hits?|honest|clean|legitimate|not lowering|fine|ok)\b)\s*(?:[-*]|\d+[.)]|\|)[^\n]*src/stats\.py'
flags: mi
match: not_contains
target:
  source: file
  path: reviews/M4-lowering.md
weight: 1
---

The honest word-count helper is not listed as a hit.
