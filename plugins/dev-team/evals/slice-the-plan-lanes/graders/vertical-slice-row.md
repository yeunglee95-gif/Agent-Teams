---
type: regex
pattern: '^\|[^|\n]*\|\s*[`*]*slice[`*]*\s*\|[^|\n]*\|(?=[^|\n]*db/)(?=[^|\n]*api/)(?=[^|\n]*ui/)[^|\n]*\|[^|\n]*\|[^|\n]*\|\s*$'
flags: m
match: contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

At least one notes lane is a vertical slice: it owns data, API and screen files together.
