---
type: regex
pattern: '(?:\b1\s*(?:of|/)\s*2\b|\b2\b[^\n]{0,40}\bnamed\b[^\n]{0,60}\b1\b[^\n]{0,20}\bran\b|\bran\b[^\n]{0,20}\b1\b[^\n]{0,60}\b2\b[^\n]{0,20}\bnamed\b|\bnamed\b[^\n]{0,10}\b2\b[^\n]{0,40}\bran\b[^\n]{0,10}\b1\b)'
flags: i
target:
  source: file
  path: reviews/M9-gate.md
weight: 2
---

The gate log puts the count that ran beside the count named: 1 of 2.
