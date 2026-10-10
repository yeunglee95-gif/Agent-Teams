---
type: regex
pattern: '(drawer|450)[\s\S]{0,600}reduced[- ]motion|reduced[- ]motion[\s\S]{0,600}(drawer|450)'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: no `prefers-reduced-motion` handling for the drawer.
