---
type: regex
pattern: '^[ \t]*(?:[-*][ \t]+)?\*{0,2}(?:Owns|Files)\b[^\n:]{0,25}:(?=(?:(?![.;] )[^\n])*(?:db|api)/notes)(?!(?:(?![.;] )[^\n])*db/notes(?:(?![.;] )[^\n])*api/notes)(?!(?:(?![.;] )[^\n])*api/notes(?:(?![.;] )[^\n])*db/notes)(?!(?:(?![.;] )[^\n])*ui/)'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

No notes lane owns one layer alone (only the notes data file, or only the notes API file).
