---
type: regex
pattern: '^-{3}\nname: copy-rules\ndescription: App copy rules for Tally\.\n-{3}\nCopy is short, plain and in both languages\.\n$'
match: contains
target:
  source: file
  path: .claude/skills/copy-rules/SKILL.md
weight: 1
---

The app's skill is unchanged.
