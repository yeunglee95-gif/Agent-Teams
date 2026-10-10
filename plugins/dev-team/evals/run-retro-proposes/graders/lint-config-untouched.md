---
type: regex
pattern: '^\{\n  "extends": \["eslint:recommended"\],\n  "rules": \{\}\n\}\n$'
match: contains
target:
  source: file
  path: .eslintrc.json
weight: 1
---

The lint config is unchanged: a new check is proposed, not added.
