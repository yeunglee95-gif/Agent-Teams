---
type: regex
pattern: '^\|[^|\n]*\|\s*[`*]*(?:slice|expand|migrate|contract)[`*]*\s*\|[^|\n]*\|(?:(?![^|\n]*\w/[\w.-])[^|\n]*\|[^|\n]*\|[^|\n]*|[^|\n]*\|(?![^|\n]*(?:\w/[\w./-]*|\.(?:test|spec)\.\w+)[^|\n]*?\s(?:>|›)\s)[^|\n]*\|[^|\n]*|[^|\n]*\|[^|\n]*\|(?![^|\n]*\w)[^|\n]*)\|\s*$'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

Every lane row lists owned files, red tests as `file > test name`, and what blocks it (or `none`).
