---
type: regex
pattern: '^(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*)(?![^\n]*(?:\b(?:tests?|e2e)/|\.(?:test|spec)\.))[^\n]*(?=(?:\n(?!(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))[^\n]*)*?\n[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b[^\n:]{0,25}:)(?:\n(?!(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))(?![^\n]*(?:\b(?:tests?|e2e)/|\.(?:test|spec)\.))[^\n]*)*(?:\n(?=(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))|(?![\s\S]))'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

Every lane (each section that names the files a lane owns) also names the red tests it starts from, by test file.
