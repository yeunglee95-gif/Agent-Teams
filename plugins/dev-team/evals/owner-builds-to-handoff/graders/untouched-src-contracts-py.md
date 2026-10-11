---
type: regex
pattern: '^from typing import TypedDict\n\n\nclass Client\(TypedDict\):\n    name: str\n    balance_cents: int\n\n\nclass LoadError\(Exception\):\n    """Raised by a loader when the client list cannot be loaded\."""\n$'
match: contains
target:
  source: file
  path: src/contracts.py
weight: 1
---

`src/contracts.py` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the lane never edits the design system, the hand-off or the frozen contract.
