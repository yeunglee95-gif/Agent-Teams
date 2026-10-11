---
type: regex
pattern: '(?:^(?:#{1,4}[ \t]|\*\*)[^\n]*\b[Cc]ontract\b(?!s)(?:[^\n]*\n(?!#{1,4}[ \t]))*?[^\n]*?\b[Bb]locked[ -]by\b[^\n]*?\w[\w-]*(?:\s*(?:,|\band\b)\s*(?:and\s+)?\w[\w-]*){1,}|^\|[^\n]*\b[Cc]ontract\b(?!s)[^\n]*\|[^\n|]*?\w[\w-]*(?:\s*(?:,|\band\b)\s*(?:and\s+)?\w[\w-]*){1,}[^\n|]*\|)'
flags: m
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

The contract lane waits for the migrate batches: its "Blocked by" names at least two lanes, in its section or in the lane table. (A batch it waits for through another batch counts.)
