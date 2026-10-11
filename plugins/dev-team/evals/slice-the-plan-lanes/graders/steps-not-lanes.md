---
type: regex
pattern: '^(?=[\s\S]*\b(?:[Cc]ontracts? (?:step|commit)|[Ss]tep\b[^\n]{0,20}\b[Cc]ontracts?\b))(?=[\s\S]*\b(?:[Ff]inal|[Ff]ull)\b[^\n]{0,20}\bgate\b)'
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

The plan names the contracts step and the final full gate as steps.
