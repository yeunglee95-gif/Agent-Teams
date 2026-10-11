---
name: run-retro
description: Use at the close of every milestone, after the owner's go or stop. Reads what went wrong in the milestone (review findings, fixes, gate failures, critic reports, the owner's rejections) and what each stage cost, and writes a proposal list for the owner, preferring a deterministic check over more prose. Proposes only; never edits a skill, hook or CLAUDE.md itself.
---

# Run retro

The team gets better between milestones, not during one. A retro turns this milestone's misses into proposals the owner approves or rejects, one by one. Nothing changes until the owner says yes, and then it ships as a new team version or a `CLAUDE.md` edit the owner approved.

## 1. Gather, from files only

Read the milestone's own records, where the app's `CLAUDE.md` says they live:

- The reviewer's finding tables and verified-fixed tables.
- The fixer's tables (finding, cause, test, paths).
- Every gate failure the gate-runner recorded, with its cause.
- The critic reports and the spec-auditor's conformance file (false done claims by lane).
- Every stop-and-ask an agent raised because the `CLAUDE.md` was silent.
- The owner's rejections and reversals, in the memory file.
- The retro proposals from earlier milestones and what the owner decided on each.
- Cost, per stage or role: turns and cost where a record has them (the session cost the app's `CLAUDE.md` names, `/usage` at each stage end, an eval's `costUsd`).
- The routing miss log: the file the app's `CLAUDE.md` names, or else `routing-log.md` next to this plugin's `evals/ROUTING.md`.

A miss you cannot point to in a file does not go in. If the `CLAUDE.md` does not say where one of these lives, stop and ask.

## 2. Group misses into classes

A class is the kind of mistake, not the instance: "a refused action shows no message", "a test that passes with the feature deleted", "a copy of a fact in a second file", "a lane edited a frozen contract". For each class: how many times this milestone, which finding ids, and whether an earlier milestone's records show it too.

A class seen in two milestones must produce a proposal. "Nothing" is not allowed for it, unless an earlier proposal for it is still waiting on the owner; then say so.

## 3. Pick the cheapest durable remedy

For each class, choose one, in this order of preference:

1. **A deterministic check.** A mechanical miss (a fixed pattern, a banned call, an import shape, a file in the wrong place, a missing test id, a hard-coded string) gets a deterministic check in the gate the gate-runner runs: a lint rule, a test that discovers the list it guards, a pre-commit hook, a CI step. First read the app's existing gate commands and CI: a check that exists but is not wired in, or is silently broken, is the finding, not a new check. A repo with no gate in CI at all is itself a finding.
2. **A skill edit.** A judgment call the reviewer or another role keeps missing: name the skill, the section and the line to add, remove or sharpen. The reviewer works from a diff and has the least context pressure, so a rule about how code should look belongs in the reviewer's checks, not in every builder's brief.
3. **A `CLAUDE.md` line.** Only for what every agent needs on every turn: a path, a command, a rule agents stopped to ask about. Keep it short; link to where the fact lives (the `claude-md-upkeep` skill).
4. **Nothing.** A one-off with no class behind it. Say why it is a one-off.

**Cost.** Write one line, `Most expensive stage: <stage> (<role>, <cost>)`, from the cost records, and look for why it cost that much. A cheaper setup for a role (another model, or lower effort) is proposed only with eval evidence, by the method in this plugin's `evals/ROUTING.md`: on the same runs, the candidate passes at least as often as the current setup and costs at least 20% less per passed run. Without that evidence, propose the eval run, not the switch. Never propose a setup the miss log lists as failed, unless the model behind it has changed. Never propose a model switch mid-session: it drops the prompt cache, so a switch applies from the next session. When an eval shows a cheaper setup failing, add one line to the miss log: date, role, setup tried, what failed.

Also look for: instructions in a skill or `CLAUDE.md` that changed nothing this milestone (candidates to remove), information an agent needed and could not reach (a log, a read-only view of an outside service), and tool calls that cost far more than the result was worth.

## 4. Write the proposal list

Where the app's `CLAUDE.md` says retro output goes. One row per proposal, most severe first:

| # | Class | Seen (ids, milestones) | Remedy type | Exact change | What it would have caught | Cost |
|---|---|---|---|---|---|---|

"Exact change" is a quoted rule, a named check with the command that runs it, or a quoted line to add or remove, with its file path. A skill edit also names the eval that must pass before and after it (the plugin's `evals/`). End with one line to the owner: how many proposals, and which one you would take if only one.

## Never

- Edit a skill, hook, agent file, gate config or `CLAUDE.md` yourself, even a one-word fix. You propose; the owner approves; the change ships as a new team version or an approved `CLAUDE.md` edit.
- Copy one app's or business's data into a proposal for the team. Propose the pattern, not the brief.
- Invent a count. Every number points to a finding id or a file.

## Source

Adapted from `skills/engineering/retro/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. Changed: rewritten in this team's voice; the input is the milestone's own finding, fixer, gate, critic and owner records instead of session logs; "review agent" mapped to this team's reviewer and "automated checks" to the gate-runner's gate; a class seen in two milestones must produce a proposal; output is a proposal list the owner approves item by item, never an edit; the `writing-for-agents` step and the tool-economy and no-op sections shortened to one line each. License text: `../../licenses/mattpocock-skills-MIT.txt`.
