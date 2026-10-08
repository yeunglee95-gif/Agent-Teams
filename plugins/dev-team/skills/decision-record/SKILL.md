---
name: decision-record
description: Use when a technical choice will be hard to undo (a framework, a data store, an outside service, a repo split or merge, a contract shape). Writes the decision record the owner signs: the options, the trade-offs, the choice, and what it makes harder later.
---

# Decision record

Write one when a choice would cost a day or more to reverse. Small choices go in the memory file as a one-line decision, not a record.

## Where it goes

Where the app's `CLAUDE.md` says. If it says nothing, ask; never pick a folder yourself. The memory file gets a one-line entry that links to the record.

## Format

```markdown
# DR-<number>: <the decision, as a short title>

Status: Proposed | Accepted | Superseded by DR-<n>
Date: <YYYY-MM-DD>
Decided by: <the owner, by name, once signed>

## Context
What forces the choice now, in a few sentences. Facts with their source.

## Options
### A: <name>
What it is. Cost, complexity, how it fails, how it would be removed later.
### B: <name>
Same.

## Recommendation
The option you recommend and why, in plain words.

## Consequences
What becomes easier. What becomes harder. What must be revisited, and when.
```

Rules:

- At least two real options. "Do nothing" counts when it is real.
- A number is traced to something measured or to a ruling; a taste call says it is one.
- Status stays Proposed until the owner says yes. The owner's words go in "Decided by".
- A reversal is a new record that supersedes the old one. The old one is never edited.
- Write so the owner, who is not a software engineer, can choose without asking what a term means.

## Source

Adapted from the decision record format in the `architecture` skill of Anthropic's `engineering` plugin (anthropics/knowledge-work-plugins, Apache License 2.0), commit 8444efcd48f7012f09797778a36a33e73d0861f4. Changed: rewritten in this team's voice, a recommendation section added, the owner's sign-off and supersede rules added. License text: `../../licenses/Apache-2.0.txt`.
