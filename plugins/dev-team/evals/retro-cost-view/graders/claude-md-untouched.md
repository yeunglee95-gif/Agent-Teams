---
type: regex
pattern: '^# Tally\n\nInvoicing app for small shops\. English and Spanish\.\n\n- Memory file: `MEMORY\.md`\. Reviews: `reviews\/`\. Fixer tables: `fixes\/`\. Gate logs: `gate\/`\.\n- Stage costs: `costs\/<milestone>-costs\.md` \(turns and cost from `\/usage` at each stage end\)\.\n- Routing miss log: `routing-log\.md`\.\n- Retro output: `retros\/<milestone>-retro\.md`\. Proposals wait for the owner \(Jase\)\.\n- Gate: `npm run lint && npm test`\.\n$'
match: contains
target:
  source: file
  path: AGENTS.md
weight: 1
---

AGENTS.md is unchanged: the retro proposes, the owner approves.
