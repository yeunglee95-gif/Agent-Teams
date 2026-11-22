---
type: regex
pattern: '^body \{ margin: 0; font: 15px\/1\.45 system-ui, sans-serif; color: #1b1f24; background: #fff; \}\nheader \{ display: flex; justify-content: space-between; align-items: center; padding: 12px 24px; border-bottom: 1px solid #e4e4e7; \}\nheader h1 \{ font-size: 18px; margin: 0; \}\n\.layout \{ display: grid; grid-template-columns: 200px 1fr; min-height: calc\(100vh - 57px\); \}\nnav \{ border-right: 1px solid #e4e4e7; padding: 16px; display: grid; gap: 8px; align-content: start; \}\nnav a \{ color: #1b1f24; text-decoration: none; padding: 6px 8px; border-radius: 8px; \}\nnav a\.on \{ background: #f4f5f7; font-weight: 600; \}\nmain \{ padding: 24px; \}\nmain h2 \{ margin: 0 0 16px; font-size: 22px; \}\n\.btn \{ background: #2457c5; color: #fff; border: 0; border-radius: 8px; padding: 10px 16px; font: inherit; font-weight: 600; \}\ntable \{ width: 100%; border-collapse: collapse; \}\ntd, th \{ text-align: left; padding: 10px 8px; border-bottom: 1px solid #e4e4e7; \}\n\.fab \{ position: fixed; right: 24px; bottom: 24px; width: 56px; height: 56px; border-radius: 50%; background: #2457c5; color: #fff; border: 0; font-size: 28px; \}\n@media \(max-width: 640px\) \{ \.layout \{ grid-template-columns: 1fr; \} nav \{ border-right: 0; border-bottom: 1px solid #e4e4e7; grid-auto-flow: column; \} \}\n$'
match: contains
target:
  source: file
  path: styles.css
weight: 1
---

`styles.css` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the design-critic reports, it never fixes.
