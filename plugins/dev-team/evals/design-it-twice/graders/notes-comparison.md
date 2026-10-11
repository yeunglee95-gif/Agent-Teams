---
type: regex
pattern: '(?:^|\n)(?=[\s\S]{0,2500}\b[Dd]epth\b)(?=[\s\S]{0,2500}\b[Ll]ocality\b)(?=[\s\S]{0,2500}\b[Ss]eams?\b)'
target:
  source: file
  path: plans/M6-design.md
weight: 2
---

The designs are weighed on depth, locality and seams in one place (a comparison section or table).
