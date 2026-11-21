---
type: regex
pattern: '^# M9 hand-off: Home, Hub and Reports\n\nAcceptance notes:\n\n- A1\. "New invoice" is reachable everywhere: a button in the header, a link in the sidebar and a floating \+ button on every page\.\n- A2\. Hub shows the same invoice table as Home, so people who look in either place find their invoices\.\n- A3\. Reports exists in the sidebar now; its content comes in a later milestone, so the page shows its heading only\.\n$'
match: contains
target:
  source: file
  path: design/handoff/M9/README.md
weight: 1
---

`design/handoff/M9/README.md` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the design-critic reports, it never fixes.
