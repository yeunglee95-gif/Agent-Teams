---
type: regex
pattern: '^body \{ margin: 0; font: 16px\/1\.5 system-ui, sans-serif; background: var\(--color-bg\); color: var\(--color-text\); \}\n\.top \{ display: flex; justify-content: space-between; align-items: center; padding: var\(--space-3\) var\(--space-4\); \}\nh1 \{ font-size: 24px; margin: 0; \}\n\.section-rule \{ border: 0; border-top: 2px solid var\(--color-signal\); margin: 0; \}\nmain \{ padding: var\(--space-4\); \}\n\.reminders \{ list-style: none; margin: 0; padding: 0; \}\n\.reminder \{ display: flex; gap: var\(--space-3\); align-items: center; padding: var\(--space-3\); background: var\(--color-surface\); border-radius: var\(--radius\); margin-bottom: var\(--space-2\); \}\n\.client \{ font-weight: 600; \}\n\.reminder-date \{ color: #6b7280; \}\n\.badge-needs-you \{ background: var\(--color-signal\); color: var\(--color-bg\); border-radius: var\(--radius\); padding: 0 var\(--space-2\); \}\n\.due-hint \{ color: var\(--color-border\); \}\nbutton \{ font: inherit; min-height: 44px; min-width: 44px; padding: 0 var\(--space-3\); border-radius: var\(--radius\); cursor: pointer; \}\nbutton:focus-visible \{ outline: 2px solid var\(--color-accent\); outline-offset: 2px; \}\n\.btn-primary \{ background: var\(--color-accent\); color: var\(--color-bg\); border: 0; \}\n\.btn-snooze \{ background: var\(--color-bg\); color: var\(--color-text\); border: 1px solid var\(--color-border\); margin-left: auto; \}\n\.btn-snooze:focus, \.btn-snooze:focus-visible \{ outline: none; \}\n\.drawer \{ position: fixed; top: 0; right: 0; bottom: 0; width: 320px; padding: var\(--space-4\); background: var\(--color-surface\); transform: translateX\(100%\); transition: transform 450ms ease-out; \}\n\.drawer\.open \{ transform: translateX\(0\); \}\n$'
match: contains
target:
  source: file
  path: styles.css
weight: 1
---

`styles.css` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the auditor reports, it never fixes.
