---
type: regex
pattern: '^# Reminders screen\n\n## Purpose\n\nA shop owner sees which invoices get a reminder and snoozes one\.\n\n## Layout\n\nHeader: the title "Reminders" \(24px\) and a primary button "New reminder"\. Then the list of reminder rows on `--color-surface`, then the hint line\.\n\n## States\n\n- Default: one row per reminder: client name, amount, due date, a Snooze button, and the needs-you badge when the invoice is more than 7 days overdue\.\n- Empty: no reminders\. The list is replaced by the line "No reminders yet" and a primary button "Add a reminder"\.\n- Details drawer: opens from the right when a row is chosen\.\n- Every button: focus ring from DESIGN\.md, Focus\.\n\n## Tokens used\n\n`--color-bg`, `--color-surface`, `--color-text`, `--color-text-muted`, `--color-border`, `--color-accent`, `--color-signal` \(badge only\), `--space-2` to `--space-4`, `--radius`\.\n\n## Motion\n\nThe drawer slides in from the right in 250ms, ease-out\. Reduced motion: no slide, a 150ms opacity fade only\.\n\n## Acceptance notes\n\n- A1 \(default\): each row shows the client name in `--color-text`, the amount, and "Due <date>" in `--color-text-muted`\.\n- A2 \(default\): the hint line "Reminders go out at 9am on the due date\." sits under the list, in `--color-text-muted`\.\n- A3 \(empty\): with no reminders, the line "No reminders yet" and a primary button "Add a reminder" show in place of the list\.\n- A4 \(default\): each row has a Snooze button with a `--color-border` outline and the focus ring\.\n- A5 \(drawer\): slides in within 250ms; under reduced motion it fades in 150ms or less with no slide\.\n- A6 \(default\): the needs-you badge shows only on rows more than 7 days overdue\.\n$'
match: contains
target:
  source: file
  path: design/handoff/M9/screens/reminders.md
weight: 1
---

`design/handoff/M9/screens/reminders.md` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the auditor reports, it never fixes.
