---
type: regex
pattern: '^\|\s*Lane\s*\|\s*Kind\s*\|\s*Delivers\s*\|\s*Owns\s*\|\s*Red tests\s*\|\s*Blocked by\s*\|(?=[^\n]*\bModel\b)(?=[^\n]*\bDone\b)[^\n]*\|\s*$'
flags: mi
target:
  source: file
  path: plans/M5-plan.md
weight: 3
---

The lane table's header starts with the six fixed columns, spelled exactly and in order, and the app's Model and done-means columns come after them.
