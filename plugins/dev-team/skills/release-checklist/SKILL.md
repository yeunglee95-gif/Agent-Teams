---
name: release-checklist
description: Use when a milestone is ready to go past staging or live. Prepares the release checklist and the rollback triggers for the owner to approve. Never releases anything itself.
---

# Release checklist

You prepare the checklist. The owner gives the go. Releasing, merging to the main branch, tagging and deploying are Red-tier actions in the app's `CLAUDE.md`, and each one waits for the owner's explicit proceed.

## Before

- [ ] Gate green on the release commit, every part and every target, with numbers (the `verify-before-done` skill).
- [ ] Reviewer's verified-fixed table signed; spec audit has no Missing row; last critic round clean.
- [ ] Security review done for this milestone, and for any dependency change since.
- [ ] No hit from the `no-quiet-lowering` skill since the branch point.
- [ ] Database changes: what they change, tested on a copy, and whether they can be undone.
- [ ] Settings and secrets the release needs exist where it runs (names only, never values).
- [ ] Rollback steps written and tried once on staging.

## Rollback triggers, decided now, not during the release

- Errors above <X>, or a key flow failing on any target.
- <a number the app's spec or the owner names, for example page load over its budget>.
- Any data loss, or a message sent to a real person by mistake: roll back at once.

Fill each `<X>` from the app's spec, its budgets or the owner. Never invent a number; leave it marked as open and ask.

## After

- [ ] The key flows checked on the live app, with screenshots.
- [ ] The scribe logs the release in the memory file with the team version and the numbers.

## Output

The filled checklist where the app's `CLAUDE.md` says, then one line to the owner: ready, or what stops it.

## Source

Adapted from the `deploy-checklist` skill in Anthropic's `engineering` plugin (anthropics/knowledge-work-plugins, Apache License 2.0), commit 8444efcd48f7012f09797778a36a33e73d0861f4. Changed: rewritten in this team's voice, tied to the team's gate, reviews and Red-tier rule, on-call and ticket steps removed. License text: `../../licenses/Apache-2.0.txt`.
