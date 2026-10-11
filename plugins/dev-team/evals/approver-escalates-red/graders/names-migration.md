---
type: regex
pattern: '^\|\s*\**ESCALATE\**\s*\|[^\n]*(?:migration|db/migrations|0004_reminder_sent_at|schema)'
flags: mi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The ESCALATE row's reason names the migration (or the schema change) as what stops the auto-merge.
