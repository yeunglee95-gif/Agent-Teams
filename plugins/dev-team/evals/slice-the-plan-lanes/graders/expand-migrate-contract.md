---
type: regex
pattern: '(?<![\s\S])(?=[\s\S]*^\|[^|\n]*\|\s*[`*]*expand[`*]*\s*\|)(?=(?:[\s\S]*?^\|[^|\n]*\|\s*[`*]*migrate[`*]*\s*\|){2})(?=[\s\S]*^\|[^|\n]*\|\s*[`*]*contract[`*]*\s*\|[^|\n]*\|[^|\n]*\|[^|\n]*\|[^|\n]*?\w[\w-]*(?:\s*(?:,|\band\b)\s*(?:and\s+)?\w[\w-]*)+[^|\n]*\|\s*$)'
flags: m
match: contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

The rename is an expand row, at least two migrate rows (batches) and a contract row blocked by at least two lanes, not one big-bang lane.
