---
type: regex
pattern: '(btn-snooze|snooze)[\s\S]{0,600}(focus|outline)|(focus|outline)[\s\S]{0,600}(btn-snooze|snooze)'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: `.btn-snooze:focus-visible { outline: none; }` removes the focus ring with no replacement.
