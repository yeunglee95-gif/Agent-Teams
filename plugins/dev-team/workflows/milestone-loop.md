# Milestone loop

The one loop the dev team runs on every project, from a request to shipped work and back, with the design team's Design stage and its part of Review on milestones that change screens. Owned by the scribe; every role reads it. The roles say who does what and the skills say how; this page says in what order, and what moves work from one stage to the next.

Everything project-specific comes from the app's `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet): the commands, the gate, the paths, the protected files, the owner, what never ships without approval, the tools it uses (an analytics tool such as PostHog, an error log, an issue tracker). Where the `AGENTS.md` is silent on something a stage needs, the role stops and asks. Nothing here overrides it.

Words used here: **the owner** is the person who gives every merge and deploy go (Jase, unless the app's `AGENTS.md` names someone else), except a merge the approver makes under a project's auto-merge setting. A **lane owner** is the `owner` role, building one lane.

## The stages

| # | Stage | Who | Gate to move on | Phase |
|---|---|---|---|---|
| 0 | Intake | the owner, or a finding from Watch (stage 14) | the owner moves the item from the backlog to ready; nothing else does | Plan |
| 1 | Grill the plan | architect, `grill-the-plan` | the owner confirms no open decision is left | Plan |
| 2 | Plan and slice | architect, `slice-the-plan`, and `architecture-critique` (design it twice when an interface is in question); then the reviewer critiques the plan | the owner approves the breakdown; every reviewer plan finding answered; the plan's lane table header starts with the six fixed columns (`slice-the-plan`) | Plan |
| 3 | Design | the design team's designer, `design-handoff`: screens, states, tokens used and acceptance notes per screen, extending the app's design system | the owner approves the design hand-off | Plan |
| 4 | Pre-flight per lane | each lane owner, with the checklist below; the milestone's claim row written first (Sessions) | each lane proceeds, holds with a `blocked-by:` line, or is sequenced behind another lane | Build |
| 5 | Build lanes | lane owners, `tests-first`; one worktree and branch per lane; a lane that builds a designed screen builds to the hand-off | the lane's named red tests are green in a gate the lane ran, with as many tests run as named | Build |
| 6 | Gate | gate-runner, the app's full gate | every part green on a fresh run, with numbers, on every target; every command that names tests ran as many as it names; CI's result on the same head reported where the app has CI | Check |
| 7 | Review | five reviewers in parallel, each its own subagent with no shared context: spec-auditor (spec check), critic (black-box, screens only), the design team's design-auditor (design check, only when screens change), security-reviewer, reviewer (code, hypotheses first) | every report filed on the same head, each with its verdict line and its Coverage line | Check |
| 8 | Combine findings | reviewer, after its own report: one combined findings table, de-duplicated, ranked and tagged by source (Combine findings, below) | every finding from every report is in the table once, or marked `disputed` with why | Check |
| 9 | Fix and re-verify | fixer, on the table's open rows in rank order; then the gate, and each reviewer whose findings were fixed re-checks them by id; at most two rounds (Limits on fixing) | no open finding; after round 2, any open blocker or major goes to the owner | Fix |
| 10 | Release check | gate-runner, `release-checklist`: merge danger, merge-gate lines, analytics events named, rollback triggers | the checklist is filled with every line checked in this turn | Ship |
| 11 | Approve | approver, read-only on code: reads every report and its coverage, the combined table, the gate numbers, CI on the reviewed head read from GitHub (CI decides, below) and the release checklist; merges only under the app's auto-merge setting (Auto-merge, below) | an APPROVE or ESCALATE line with its reason in the approval table, and the Raw checks section under it | Ship |
| 12 | Owner go | **the owner** | the owner reads the approval file's Raw checks, then merges or deploys, or says who does, each time; skipped for a merge the approver made under auto-merge | Ship |
| 13 | Retro | scribe, `run-retro`, then the handoff note and the claim row closed (Sessions) | proposals on the owner's desk; each approved, rejected or parked by the owner | Learn |
| 14 | Watch | whoever the app's `AGENTS.md` names, reading its analytics tool and error log for the shipped change | findings filed to the backlog, never to ready | Learn |

**Design** (stage 3) and the design-auditor's part of **Review** (stage 7) run only for a milestone that changes screens; for a milestone with no screen change both are skipped, and the plan says so in one line. They are run by the design team (the `design-team` plugin in this repo); where the app has no design team installed, the owner says who covers them or rules them out for the milestone. The Phase column groups the stages for tools that draw the loop; it changes no gate.

A finding at any stage goes back to the stage that owns it (a spec gap to the architect, a design gap to the designer, a red test to the lane or fixer), never around it.

## Review: five at once (stage 7)

The main session starts every reviewer at the same time, each as its own subagent with its own brief, and every brief carries the plan's Review Focus list word for word: the spec-auditor, the critic, the design-auditor (only when screens change), the security-reviewer and the reviewer. They share no context. None reads another's report, the combined table or any builder's account before its own report is filed, and each names the head sha it reviewed. The reviewer writes its hypotheses from the spec and the raw diff before it reads any other report or any lane's account. The critic works from the screen only and never reads the code first. Every report ends with one Coverage line, so what was not reviewed is written down instead of assumed:

`Coverage: head <sha>; checked: <paths, spec rows, screens, tests run, targets, languages>; not checked: <what, and why, or none>`

The reviewer, the spec-auditor and the security-reviewer list paths; the critic and the design-auditor list screens, targets and languages. The approver reads every line against the diff: a changed path that no code-reading review checked stops the approval.

Each report keeps its own finding ids (spec rows for the spec-auditor, `<Persona> <Round>-<N>` for the critic, `D<N>` for the design-auditor, `SEC<N>` for the security-reviewer, `R<N>` for the reviewer) and the team's severities: blocker, major, minor. For the spec-auditor, a Missing row is a blocker, and a Partial row or a High test gap is a major.

## Combine findings (stage 8)

Nothing moves until every report from stage 7 is filed. Then the reviewer, whose own report is already written, reads the others and builds one table, because it re-verifies fixes later and already reads the code. It goes in `<milestone>-findings.md` beside the reviews, unless the app's `AGENTS.md` names another place, and the fixer, the approver and the checks all read it:

`| ID | Severity | Source | Finding | Where | Kind | Status |`

- **ID**: `C1`, `C2`, and on; never reused in the milestone.
- **Severity**: blocker, major or minor. When sources disagree on one finding, the highest wins.
- **Source**: every role, by its exact role name (`spec-auditor`, `critic`, `design-auditor`, `security-reviewer`, `reviewer`), and its own finding id, separated by semicolons (for example `critic Ana 1-1; reviewer R2; spec-auditor S9.1`). A finding two reports share is one row with both sources, never two rows.
- **Finding**: one sentence.
- **Where**: `path:line`, or the screen, target and language, or both.
- **Kind**: `behavior` when the fix changes what the code does (logic, state, data, a contract, an engine or run path, anything security); `surface` when it changes only what is shown or named (copy, labels, i18n keys, styling, layout, docs) and no test of behavior moves. A security-reviewer finding is always `behavior`; when unsure, `behavior`. The Kind picks the fixer's first model (Fixer step-up).
- **Status**: `open`; `disputed: <why>` when the reviewer checked it against the code or the build and finds it wrong (it goes back to its source to confirm or withdraw, never to the fixer as written); `deferred` for scope the plan defers; after a fix round, `fixed <sha>` once its source re-verified it, or `open` again.

Below the table, a **Declined to judge** section gathers every behavior a reviewer set aside as outside the spec or plan, with its source and reason. The architect rules on each line before stage 9: it becomes a row (`open`, graded by what a person using the app gets if it ships), or it is recorded as not required, with the reason, in the memory file. A finding is graded by its effect, not by whether the spec names the input; the spec says what the app must do, not everything it will meet.

Rows are ranked: every blocker, then every major, then every minor. The reviewer adds no new finding of its own here; a finding it missed goes into its own report first, with its next id.

## CI decides (stages 6 and 11)

Where the app's `AGENTS.md` names CI (`CI: <the required checks>` and how to read them), CI's result on the reviewed head is the binding gate. The gate-runner reports it beside its local numbers; the approver reads it itself from GitHub for the exact reviewed head sha and approves only when every named check concluded `success` on that sha. Failed, cancelled, pending, missing or skipped is red, and so is green on another sha. When CI and the local gate disagree, CI wins. When the approver cannot read CI, it escalates. An app with no CI line keeps the local gate as its only gate.

**Tests named are tests run.** Any command that names tests (a filter, a file list, a list of names) reports how many it named and how many ran; fewer ran than named is red even when every test that ran passed.

**Raw checks at the owner's go.** The approval file carries the commands the approver ran and their output as printed, so the owner gives the go on what was run, not on a summary of it.

## Auto-merge

Off unless the app's `AGENTS.md` turns it on, per project. It needs two lines there: `Auto-merge: safe changes` (or `Auto-merge: off`) and a line saying whether merging to main deploys (`Merging to main deploys: no`, or `yes`). If either line is missing, auto-merge is off. Optional lines: `Auto-merge size limit: <N> changed lines` (default 400), `Auto-merge may deploy: yes`, and an always-ask list. Only the approver merges under it, and only inside the limits written in its role (`agents/approver.md`, Auto-merge policy). Sending, spending, publishing and touching live data stay the owner's whatever the setting. With auto-merge off, an APPROVE goes to the owner for the go at stage 12.

## Sessions

How Claude Code sessions map to milestones, so parallel work does not collide and the prompt cache is not thrown away. A model switch mid-session drops the cache (`/model`, a plan-mode model toggle, a skill whose frontmatter names another model); an effort change on the 5.5 models keeps it. Each subagent has its own cache and its first request is uncached.

- **One main session per milestone.** Parallel milestones run as parallel sessions, never as one long chat for several. The main session's model is fixed for its whole life; its effort may change.
- **The main session delegates reading.** Big files and searches go to a subagent that returns a summary. Prefer a few substantial subagents over many tiny ones, because each new one starts uncached.
- **Claim board.** Before a milestone session starts any lane, it checks the claim board in the status file the app's `AGENTS.md` names (the roadmap) and writes its own row: milestone, session or owner, branch or worktree, owned paths, started date. A session never edits another milestone's row. The row is closed at Close.
- **Cross-milestone pre-flight and sweep.** Pre-flight question 3 covers other milestones' claimed paths and open pull requests; the sweep at each stage start re-reads the memory file and the claim board (Blocked items).
- **Shared things.** Contract files change only through the architect. Each milestone writes its decisions into its own dated section of the memory file, so two sessions never edit the same lines.
- **Messages between sessions** are heads-ups only; the files are the record.
- **Retry cap.** After one failed repair, escalate: first the same role with more effort, then the owner or a stronger role. A Stop or SubagentStop hook that forces the agent to continue must carry a hard round cap.
- **Fixer step-up.** The fixer's first attempt runs on `opus` for a `behavior` row and on `sonnet` for a `surface` row (the combined table's Kind). When a `sonnet` repair fails, the main session runs the next attempt on that finding with the fixer on `opus`, by passing the model for that one subagent call. It never switches the main session's model, so the session's prompt cache stays intact. The `opus` attempt gets the failed attempt's cause line and diff. How many attempts and rounds there are, and what goes to the owner, is in Limits on fixing. The next `surface` finding starts on `sonnet` again. A `behavior` row that fails on `opus` gets one more `opus` attempt with the first's cause line and diff.
- **Close.** The scribe writes a handoff note (decisions, open items, the next milestone's first step) where the app's `AGENTS.md` says, or else beside the retro, then the retro, and closes the milestone's claim row. The next milestone starts in a fresh session from the `AGENTS.md`, the memory file and that note.

## Pre-flight, before a lane starts (stage 4)

The lane owner answers five questions and writes the answers in the lane's first message, before touching a worktree:

1. **Already done?** A merged change, a closed item or code already on the base branch that delivers the same behavior, under any name.
2. **Already in progress?** Another lane, branch or open pull request doing the same thing.
3. **Overlapping files?** Another lane, another milestone's claimed paths on the claim board, or an open pull request touching the files this lane owns. Two lanes that overlap go one at a time: the earlier one proceeds, the later one is sequenced with `blocked-by:` the earlier one (for another milestone, `blocked-by:` that milestone).
4. **Unclear?** The spec row or red test is missing, or it contradicts the current code (cite `path:line`). Unclear goes back to the architect; a missing screen, state or token in the design hand-off goes back to the designer. The lane never decides it.
5. **Too big?** Likely to change more lines than the app's `AGENTS.md` allows for one lane, or spanning many areas at once. Too big goes back to the architect to split.

After **proceed**, the lane's first act in its new worktree is a clean-start check: the unit suite runs before the first edit, and a red baseline holds the lane with `blocked-by:` naming the failing tests.

Outcomes: **proceed**; **hold** (the item stops with a `blocked-by:` line and one sentence on why); or **sequence** (it waits for the named lane). A lane with no recorded answer is not started.

## Blocked items

- Every blocked item carries one line: `blocked-by: <the item, lane, decision or person it waits on>`, or `blocked-by: -` when it waits on the owner's decision with no other item. The scribe keeps these lines on the status board.
- **Sweep at each stage start.** Before a stage starts, the scribe re-reads the memory file and the claim board, and checks every `blocked-by:` line. An item whose blocker has closed goes back into the loop at the stage it left, with a note naming what cleared it. An item waiting on the owner stays on the owner's page with what it holds up.

## Limits on fixing

One set of limits for stage 9 and for any repair. A repair **fails** when its test stays red, the gate goes red, or the source's re-verification rejects it. Each failure is recorded as one cause line: the stage, the kind of failure (test assertion, test crash, build, lint, merge conflict, network, access, other) and the first `path:line` frames.

| Limit | How it counts | When it is reached |
|---|---|---|
| Two attempts per finding | a `behavior` row: both attempts on `opus`; a `surface` row: the first on `sonnet`, the second on `opus`; the second always gets the first's cause line and diff (Fixer step-up) | a second failure sends the finding to the owner with both attempts, whatever its cause |
| Two fix rounds per milestone | one round is the fixer on every open row of the combined table, then the gate on the new head, then each reviewer whose findings were fixed re-checking them by id | after round 2, any open blocker or major sends the milestone to the owner with the table; open minors stay listed for the approver |
| Same root cause twice | outside a fix round (a gate, a lane's build, a review), the same item failing twice in a row with the same cause line; a different cause resets the count | the item goes to the owner with both attempts |

**How a round closes.** Each source re-checks its own fixed findings by id and gives each one a verdict: `fixed`, with the `path:line` or test run that shows the defect is gone, or `not fixed`, with what still shows it. "Attempted" is not fixed. Each source also reports any **new breakage in the fix diff** (something the fix itself broke, with severity and `path:line`), which enters the table as a new row. Something noticed outside the fix diff goes into that source's own report as a new finding with its next id and into the table, and does not reopen the round on its own.

**Sort the fix diff.** Before the re-checks, the reviewer sorts the round's diff (`git diff <head the reviews saw>..<new head>`) by path. A change to behavior, tests or build inputs outside the paths of the findings it fixed gets a full review pass of that part by the reviewer and the security-reviewer in the same round, as if it were new work. A change only to docs or release metadata keeps the earlier reviews. The sort and its outcome are one line in the reviewer's verified-fixed table.

These sit on top of the three-strikes rule in `root-cause-debugging` and the retry cap in Sessions. A repair that turns a check green by adding an exception, an allow-list or baseline entry, or a narrower rule to a ruling test (a test that holds one of the app's rules across the code, such as a banned-terms list, a duplicate set or a form-file map) is not a fix: it fails as a repair unless the architect signed off the rule change in the memory file before the fixer's commit. The reviewer checks for it when it re-verifies (the `no-quiet-lowering` skill, "An exception appeared").

A finding's second attempt can fall in round 1 (its test stayed red) or round 2 (its re-verification rejected it); either way it never gets a third.

## Halts

- **No progress.** If two rounds in a row move no item forward a stage, the loop halts. The scribe writes what each item is waiting on and why, and asks the owner how to go on.
- **Anything destructive** (a live database change, a secret rotation, a deploy) halts the loop and goes to the owner, even when every check is green. Auto-merge never covers it.
- **Escalated.** An ESCALATE from the approver puts the milestone on the owner's page with its reason and `blocked-by: -`; nothing moves until the owner says.

## What the loop never does

- Merge on its own. No role merges, tags or deploys, except the approver merging a change inside the auto-merge limits of a project that turned it on (Auto-merge); the owner gives every other go, each time.
- Merge when CI failed to start, is red or still running on the reviewed head, or went green only on another sha; or call a gate green that did not run, or a filtered run green when it ran fewer tests than it names.
- File follow-up work straight into ready. New work, refactor ideas and Watch findings go to the backlog; the owner moves them on.
- Let a lane decide a judgment call without asking. A lane stops and asks the architect or the owner.
- Let a reviewer (the spec-auditor, critic, design-auditor, security-reviewer or reviewer) or the approver patch code. They write findings or decisions; the fixer fixes.
- Install an outside skill or tool unpinned. Every outside source is pinned to a commit and recorded in `THIRD_PARTY.md`.
- Edit a skill, hook, agent file or `AGENTS.md` (or `CLAUDE.md`) without the owner's approval. Retro output is proposals.

## Source

Generalized from OS Flow's build loop and the stage table in spec 16 section 7 (Agent-Teams session, 2026-10-10). The pre-flight questions, the `blocked-by:` line and its sweep, the same-root-cause cap and the no-progress halt are adapted from `skills/super-board/references/run.md` ("Builder pre-flight", "Halt gates", "Root-cause hash") and `skills/super-board/references/run-workflow.md` (the wave-start sweep) in EricTechPro/super-board (MIT, Copyright (c) 2026 Eric Tech), commit 35e215615c98fa5da011368e764f38f86959bf95. Changed: rewritten in this team's voice; GitHub Project columns, scripts, model routing and robot accounts removed; the hash became a written cause line; the cap goes to the owner instead of a blocked column; the halt is after two rounds instead of three ticks; super-board's default-on automatic merge, the merge when CI failed to start and the worker decision ladder are not taken (see `skills/REJECTED.md`). The parallel review stage, the combined findings table, the two-round fix limit, the approver and the opt-in auto-merge are this team's own, from the owner's 2026-10-11 scope after comparing this loop with a published software-factory loop (spec writer, builder, four parallel reviews, wait for all, at most two fix rounds, an approver that merges or escalates). License text: `../licenses/erictechpro-super-board-MIT.txt`.
