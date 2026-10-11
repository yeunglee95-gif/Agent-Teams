---
type: regex
pattern: '^# M4 hand-off: clients\n\nMilestone M4 adds the clients screen\. One screen: `screens/clients\.md`\. Design system read: `DESIGN\.md` as of this commit\. No proposals to the design system\. No open questions\.\n$'
match: contains
target:
  source: file
  path: design/handoff/M4/README.md
weight: 1
---

`design/handoff/M4/README.md` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the lane never edits the design system, the hand-off or the frozen contract.
