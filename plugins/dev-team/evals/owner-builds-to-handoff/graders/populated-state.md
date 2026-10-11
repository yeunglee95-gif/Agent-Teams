---
type: regex
pattern: '^(?=[\s\S]*clients-screen)(?=[\s\S]*\bpopulated\b)(?=[\s\S]*clients-list)(?=[\s\S]*client-row)'
target:
  source: file
  path: src/screens/clients.py
weight: 1
---

The populated state uses the hand-off's hooks: the `clients-screen` root with `data-state` populated, the `clients-list` list and `client-row` rows.
