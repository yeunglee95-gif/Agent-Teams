---
type: regex
pattern: '(?<![\s\S])(?![\s\S]*\|[^\n]*\b[Bb]locked[ -]by\b[^\n]*\|)[\s\S]*?^(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*)(?![^\n]*\b[Bb]locked[ -]by\b)[^\n]*(?=(?:\n(?!(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))[^\n]*)*?\n[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b[^\n:]{0,25}:)(?:\n(?!(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))(?![^\n]*\b[Bb]locked[ -]by\b)[^\n]*)*(?:\n(?=(?:#{1,4}[ \t]|\*\*(?![^\n*]*:\*\*)(?![^\n*]*\*\*:)[^\n*]{1,120}\*\*))|(?![\s\S]))'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

Every lane says what blocks it (or "none"), in its own section or in a lane table with a "Blocked by" column.
