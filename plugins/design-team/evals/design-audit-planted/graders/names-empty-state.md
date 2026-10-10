---
type: regex
pattern: 'empty[- ]state|No reminders yet'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: `app.js` renders no empty state; the hand-off (A3) asks for "No reminders yet" and "Add a reminder".
