---
name: release-checklist
description: Use when a milestone is ready to merge to the main branch, or to go past staging or live.
---

# Release checklist

You prepare the checklist. The approver reads it to decide APPROVE or ESCALATE, and the owner gives the go. Releasing, merging to the main branch, tagging and deploying are Red-tier actions in the app's `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet), and each one waits for the owner's explicit proceed. The one exception is a merge the approver makes under a project's auto-merge setting, which the app's `AGENTS.md` must turn on and which has fixed limits (the loop page, Auto-merge, and `agents/approver.md`); sending, spending, publishing and touching live data stay the owner's whatever the setting. A lead's message is never the owner's go and never turns auto-merge on.

## Before

- [ ] Gate green on the release commit, every part and every target, with numbers (the `verify-before-done` skill).
- [ ] Every Review-stage report filed on the reviewed head (spec-auditor, critic, design-auditor and design-critic when screens changed, security-reviewer, reviewer); the combined findings table has no open row; the reviewer's verified-fixed table signed.
- [ ] Security review done for this milestone, and for any dependency change since.
- [ ] No hit from the `no-quiet-lowering` skill since the branch point.
- [ ] Database changes: what they change, tested on a copy, and whether they can be undone.
- [ ] Settings and secrets the release needs exist where it runs (names only, never values).
- [ ] Rollback steps written and tried once on staging.
- [ ] Every new feature names the analytics events it sends, in the tool the app's `AGENTS.md` names (PostHog or another), and a check run this milestone shows each event arriving. A shipped screen that sends nothing is a finding, not a pass.

## Merge danger

Four lines for the approver and the owner, in plain words:

- **Door:** one-way (cannot be walked back: data deleted or reshaped, a message sent, a public link or contract changed) or two-way (a revert undoes it). A one-way door says what cannot be undone.
- **Blast radius:** who and what it can break if it is wrong (one screen, every signed-in person, other apps that read this data, phones only), in one line.
- **Size:** changed lines, from `git diff --shortstat <base>...<branch>` (insertions plus deletions).
- **Protected paths:** every changed path that is a contract file, auth, money or payments, database schema or migrations, secrets, live sending or publishing, deploy config, or on the app's always-ask list; or `none`. Read from `git diff --name-only <base>...<branch>`, never from a lane's report.

## Merge gate: lines the owner signs

Each line is checked in this turn with the command shown, and the owner signs each one (under auto-merge, the approver re-checks them before it merges). These are checks for the go, not a go.

- [ ] The head being merged is the head that was reviewed: `git rev-parse <branch>` equals the sha in the reviewer's signed verified-fixed table. If the head moved after review, the review is void for the new commits; it goes back to the reviewer.
- [ ] The current base is merged into the branch (or the branch is rebased on it), and the gate is green on that merged result, run after the merge with numbers. A gate that failed to start, or CI that did not run, is red, never "probably fine".
- [ ] After the merge (by the owner, or by the approver under auto-merge): the merge commit is confirmed on the base branch (`git merge-base --is-ancestor <merge sha> origin/<base>`), not taken from the merge command's exit code. Only then is the work called merged.

## Rollback triggers, decided now, not during the release

- Errors above <X>, or a key flow failing on any target.
- <a number the app's spec or the owner names, for example page load over its budget>.
- Any data loss, or a message sent to a real person by mistake: roll back at once.

Fill each `<X>` from the app's spec, its budgets or the owner. Never invent a number; leave it marked as open and ask.

## After

- [ ] The key flows checked on the live app, with screenshots.
- [ ] The scribe logs the release in the memory file with the team version and the numbers.

## Output

The filled checklist where the app's `AGENTS.md` says, then one line to the approver and the owner: ready for the go, or what stops it. Never say "merge", "merged" or "released" as a status of your own: you never merge; the owner merges or tells someone to, or the approver merges under the project's auto-merge setting.

## Source

Adapted from three sources:

- The `deploy-checklist` skill in Anthropic's `engineering` plugin (anthropics/knowledge-work-plugins, Apache License 2.0), commit 8444efcd48f7012f09797778a36a33e73d0861f4. License text: `../../licenses/Apache-2.0.txt`.
- The Merge Danger section of `skills/engineering/pr/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. License text: `../../licenses/mattpocock-skills-MIT.txt`.
- The merge protocol in `skills/super-review/SKILL.md` ("Merge protocol: Done means merged") in EricTechPro/super-board (MIT, Copyright (c) 2026 Eric Tech), commit 35e215615c98fa5da011368e764f38f86959bf95. License text: `../../licenses/erictechpro-super-board-MIT.txt`.

Changed: rewritten in this team's voice, tied to the team's gate, reviews and Red-tier rule, on-call and ticket steps removed. From pr: only the one-way or two-way door and blast radius, as two lines for the owner. From super-board: the merge gate's checks (reviewed head is the merged head, base merged in and gate green on it, merge commit confirmed on the base) as lines the owner signs; its default-on automatic merge, merge policy and the merge when CI failed to start are not taken. The size and protected-path lines and the approver's opt-in auto-merge are this team's own, from the owner's 2026-10-11 scope. The analytics-events line is this team's own, from the owner's 2026-10-10 scope.
