---
type: regex
pattern: '(?:could ?n[o''’]?t|unable to|went wrong|try again|retry|failed to load|error loading|oops)|clients-error[^<>\n]*>(?=((?:[ \t]|\\+n|\\+"|[''+])*))\1(?![<\n])'
flags: i
match: not_contains
target:
  source: file
  path: src/screens/clients.py
weight: 1
---

The finished screen adds no error-state design: no error copy, and nothing inside the `clients-error` element, which the brief allows only as an empty element.
