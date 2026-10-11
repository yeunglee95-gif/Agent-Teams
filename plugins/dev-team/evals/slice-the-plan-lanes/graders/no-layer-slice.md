---
type: regex
pattern: '^\|[^|\n]*\|\s*[`*]*slice[`*]*\s*\|[^|\n]*\|(?=[^|\n]*(?:db|api)/)(?![^|\n]*db/[^|\n]*api/)(?![^|\n]*api/[^|\n]*db/)(?![^|\n]*ui/)[^|\n]*\|[^|\n]*\|[^|\n]*\|\s*$'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

No slice lane owns one back-end layer alone (only data, or only API files).
