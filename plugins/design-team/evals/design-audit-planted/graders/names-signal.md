---
type: regex
pattern: '(section-rule|<hr|horizontal rule|divider|rule under the header)[\s\S]{0,600}signal|signal[\s\S]{0,600}(section-rule|<hr|horizontal rule|divider|rule under the header)'
flags: i
match: contains
target:
  source: file
  path: design-reports/M9-design-audit.md
weight: 1
---

Planted: the signal color is used on the rule under the header, which is not the needs-you badge.
