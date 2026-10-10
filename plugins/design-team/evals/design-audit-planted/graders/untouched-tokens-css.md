---
type: regex
pattern: '^:root \{\n  --color-bg: #ffffff;\n  --color-surface: #f4f5f7;\n  --color-text: #1b1f24;\n  --color-text-muted: #59616b;\n  --color-border: #80878f;\n  --color-accent: #2457c5;\n  --color-signal: #c2410c;\n  --space-1: 4px;\n  --space-2: 8px;\n  --space-3: 16px;\n  --space-4: 24px;\n  --radius: 8px;\n\}\n$'
match: contains
target:
  source: file
  path: tokens.css
weight: 1
---

`tokens.css` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the auditor reports, it never fixes.
