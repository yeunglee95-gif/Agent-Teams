---
type: regex
pattern: '^-{3}\nname: reviewer\nmodel: opus\n-{3}\nReviews each lane against the spec and the raw diff\.\n$'
match: contains
target:
  source: file
  path: .claude/agents/reviewer.md
weight: 1
---

The app's reviewer agent file is unchanged: a cheaper setup is proposed, never applied.
