---
type: regex
pattern: '^# Tally design system\n\n## Tokens\n\nEvery color, spacing value and radius comes from `static/tokens\.css`\. No literal color value appears anywhere else\.\n\n\| Token \| Value \| Use \|\n\|-{3}\|-{3}\|-{3}\|\n\| `--color-bg` \| #ffffff \| page background, text on accent \|\n\| `--color-surface` \| #f4f5f7 \| rows, panels \|\n\| `--color-text` \| #1b1f24 \| body text \|\n\| `--color-text-muted` \| #59616b \| secondary text \(6\.3:1 on bg, 5\.8:1 on surface\) \|\n\| `--color-border` \| #80878f \| control borders and dividers only, never text \|\n\| `--color-accent` \| #2457c5 \| primary actions, links, the focus ring \|\n\| `--space-1` to `--space-4` \| 4px, 8px, 16px, 24px \| spacing \|\n\| `--radius` \| 8px \| every corner \|\n\n## Focus\n\nEvery control shows the focus ring on `:focus-visible`: `outline: 2px solid var\(--color-accent\); outline-offset: 2px`\. The ring is never removed\.\n\n## Targets\n\nEvery control is at least 44 by 44px\.\n$'
match: contains
target:
  source: file
  path: DESIGN.md
weight: 1
---

`DESIGN.md` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the lane never edits the design system, the hand-off or the frozen contract.
