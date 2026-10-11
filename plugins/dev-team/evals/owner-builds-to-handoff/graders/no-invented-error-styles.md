---
type: regex
pattern: '[.#\[][^{}\s]*error[^{}\n;*/]*\{|--[\w-]*error'
flags: i
match: not_contains
target:
  source: file
  path: static/clients.css
weight: 1
---

The finished styles add no error-state design: no error selector and no error token.
