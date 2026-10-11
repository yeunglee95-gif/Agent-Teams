---
type: regex
pattern: '(?<![&\w])#(?!(?:ffffff|fff|f4f5f7|1b1f24|59616b|80878f|2457c5)(?![\w-]))[0-9a-f]{3,8}(?![\w-])'
flags: i
match: not_contains
target:
  source: file
  path: static/clients.css
weight: 1
---

The finished `static/clients.css` has no hex color that DESIGN.md does not list. Checked on the file, not the trace, so a color added for a moment to watch a guard test fail is fine.
