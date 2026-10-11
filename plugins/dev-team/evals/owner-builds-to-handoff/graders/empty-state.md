---
type: regex
pattern: '^(?=[\s\S]*clients-empty)(?=[\s\S]*No clients yet)(?=[\s\S]*Add a client)(?=[\s\S]*add-client)(?=[\s\S]*\bempty\b)'
target:
  source: file
  path: src/screens/clients.py
weight: 1
---

The empty state is built from the hand-off: `clients-empty` with "No clients yet", and the `add-client` button "Add a client", with `data-state` empty.
