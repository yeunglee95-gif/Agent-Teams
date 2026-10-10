---
type: regex
pattern: '(due-hint|hint line|hint text|9am)[\s\S]{0,600}contrast|contrast[\s\S]{0,600}(due-hint|hint line|hint text|9am)'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: the hint line uses `--color-border` (#80878f) as text, 3.6:1 on white, under the 4.5:1 floor.
