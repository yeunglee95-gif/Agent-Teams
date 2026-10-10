# Milestone loop

The one loop the dev team runs on every project, from a request to shipped work and back. Owned by the scribe; every role reads it. The roles say who does what and the skills say how; this page says in what order, and what moves work from one stage to the next.

Everything project-specific comes from the app's `CLAUDE.md`: the commands, the gate, the paths, the protected files, the owner, what never ships without approval, the tools it uses (an analytics tool such as PostHog, an error log, an issue tracker). Where the `CLAUDE.md` is silent on something a stage needs, the role stops and asks. Nothing here overrides it.

Words used here: **the owner** is the person who gives every merge and deploy go (Jase, unless the app's `CLAUDE.md` names someone else). A **lane owner** is the `owner` role, building one lane.

## The stages

| # | Stage | Who | Gate to move on |
|---|---|---|---|
| 0 | Intake | the owner, or a finding from Watch (stage 13) | the owner moves the item from the backlog to ready; nothing else does |
| 1 | Grill the plan | architect, `grill-the-plan` | the owner confirms no open decision is left |
| 2 | Plan and slice | architect, `slice-the-plan`, and `architecture-critique` (design it twice when an interface is in question); then the reviewer critiques the plan | the owner approves the breakdown; every reviewer plan finding answered |
| 3 | Pre-flight per lane | each lane owner, with the checklist below | each lane proceeds, holds with a `blocked-by:` line, or is sequenced behind another lane |
| 4 | Build lanes | lane owners, `tests-first`; one worktree and branch per lane | the lane's named red tests are green in a gate the lane ran |
| 5 | Gate | gate-runner, the app's full gate | every part green on a fresh run, with numbers, on every target |
| 6 | Spec check | spec-auditor, conformance table and test-gap table (`hidden-failure-check`) | no Missing row and no High test gap open |
| 7 | Black-box check | critic, screens and evidence only, never the code first | report filed for each persona; zero blockers and zero majors on every target |
| 8 | Review | reviewer: hypotheses from the spec and raw diff before any builder's report; findings labeled Gap, Bug, Verification miss, Scope drift, Over-engineering; earlier findings re-checked by id | no blocking finding open |
| 9 | Fix and re-verify | fixer, then the reviewer's verified-fixed table, signed with the head sha | every finding fixed and re-verified; the same root cause twice stops (see caps) |
| 10 | Release check | gate-runner, `release-checklist`: merge danger, merge-gate lines, analytics events named, rollback triggers | the owner signs the checklist |
| 11 | Owner go | **the owner** | the owner merges or deploys, or says who does, each time |
| 12 | Retro | scribe, `run-retro` | proposals on the owner's desk; each approved, rejected or parked by the owner |
| 13 | Watch | whoever the app's `CLAUDE.md` names, reading its analytics tool and error log for the shipped change | findings filed to the backlog, never to ready |

A finding at any stage goes back to the stage that owns it (a spec gap to the architect, a red test to the lane or fixer), never around it.

## Pre-flight, before a lane starts (stage 3)

The lane owner answers five questions and writes the answers in the lane's first message, before touching a worktree:

1. **Already done?** A merged change, a closed item or code already on the base branch that delivers the same behavior, under any name.
2. **Already in progress?** Another lane, branch or open pull request doing the same thing.
3. **Overlapping files?** Another lane or open pull request touching the files this lane owns. Two lanes that overlap go one at a time: the earlier one proceeds, the later one is sequenced with `blocked-by:` the earlier one.
4. **Unclear?** The spec row or red test is missing, or it contradicts the current code (cite `path:line`). Unclear goes back to the architect; the lane never decides it.
5. **Too big?** Likely to change more lines than the app's `CLAUDE.md` allows for one lane, or spanning many areas at once. Too big goes back to the architect to split.

Outcomes: **proceed**; **hold** (the item stops with a `blocked-by:` line and one sentence on why); or **sequence** (it waits for the named lane). A lane with no recorded answer is not started.

## Blocked items

- Every blocked item carries one line: `blocked-by: <the item, lane, decision or person it waits on>`, or `blocked-by: -` when it waits on the owner's decision with no other item. The scribe keeps these lines on the status board.
- **Sweep at each stage start.** Before a stage starts, the scribe checks every `blocked-by:` line. An item whose blocker has closed goes back into the loop at the stage it left, with a note naming what cleared it. An item waiting on the owner stays on the owner's page with what it holds up.

## Caps and halts

- **Same root cause twice.** When a fix, gate or review fails, the role records the cause in one line: the stage, the kind of failure (test assertion, test crash, build, lint, merge conflict, network, access, other) and the first `path:line` frames. If the same item fails twice in a row with the same cause line, it stops and goes to the owner with both attempts. A different cause resets the count. This sits on top of the three-strikes rule in `root-cause-debugging`.
- **No progress.** If two rounds in a row move no item forward a stage, the loop halts. The scribe writes what each item is waiting on and why, and asks the owner how to go on.
- **Anything destructive** (a live database change, a secret rotation, a deploy) halts the loop and goes to the owner, even when every check is green.

## What the loop never does

- Merge on its own. No role merges, tags or deploys; the owner gives the go each time.
- Merge when CI failed to start, or call a gate green that did not run.
- File follow-up work straight into ready. New work, refactor ideas and Watch findings go to the backlog; the owner moves them on.
- Let a lane decide a judgment call without asking. A lane stops and asks the architect or the owner.
- Let the reviewer patch code. The reviewer writes findings; the fixer fixes.
- Install an outside skill or tool unpinned. Every outside source is pinned to a commit and recorded in `THIRD_PARTY.md`.
- Edit a skill, hook, agent file or `CLAUDE.md` without the owner's approval. Retro output is proposals.

## Source

Generalized from OS Flow's build loop and the stage table in spec 16 section 7 (Agent-Teams session, 2026-10-10). The pre-flight questions, the `blocked-by:` line and its sweep, the same-root-cause cap and the no-progress halt are adapted from `skills/super-board/references/run.md` ("Builder pre-flight", "Halt gates", "Root-cause hash") and `skills/super-board/references/run-workflow.md` (the wave-start sweep) in EricTechPro/super-board (MIT, Copyright (c) 2026 Eric Tech), commit 35e215615c98fa5da011368e764f38f86959bf95. Changed: rewritten in this team's voice; GitHub Project columns, scripts, model routing and robot accounts removed; the hash became a written cause line; the cap goes to the owner instead of a blocked column; the halt is after two rounds instead of three ticks; the automatic merge, the merge when CI failed to start and the worker decision ladder are not taken (see `skills/REJECTED.md`). License text: `../licenses/erictechpro-super-board-MIT.txt`.
