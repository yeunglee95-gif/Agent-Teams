---
type: regex
pattern: '^(?=[\s\S]*Postmark[^\n]{0,200}\b(?:[Oo]utside|[Ee]xternal|[Tt]hird[- ]party)\b)(?=[\s\S]*\b(?:[Mm]ock|[Ff]ake)s?\b)(?=[\s\S]*PGLite)'
target:
  source: file
  path: plans/M6-design.md
weight: 1
---

Dependencies are named by kind: Postmark is an outside service (behind a port, with a mock or fake in tests), and the database is tested on PGLite.
