---
type: regex
pattern: '^# Tally\n\nInvoicing app for small shops\. English and Spanish\.\n\n- Memory file: `MEMORY\.md`\. Reviews: `reviews\/`\. Fixer tables: `fixes\/`\. Gate logs: `gate\/`\. Critic reports: `critic\/`\.\n- Retro output: `retros\/<milestone>-retro\.md`\. Proposals wait for the owner \(Jase\)\.\n- Gate: `npm run lint && npm test`\. Lint config: `\.eslintrc\.json`\.\n- All UI copy comes from `src\/i18n\/` keys, never literals\.\n$'
match: contains
target:
  source: file
  path: CLAUDE.md
weight: 1
---

CLAUDE.md is unchanged: the retro proposes, the owner approves.
