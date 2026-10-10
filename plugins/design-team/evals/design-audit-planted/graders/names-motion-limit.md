---
type: regex
pattern: 'drawer[\s\S]{0,600}450|450[\s\S]{0,600}drawer'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: the drawer transition is 450ms, over the 300ms limit (and the hand-off says 250ms).
