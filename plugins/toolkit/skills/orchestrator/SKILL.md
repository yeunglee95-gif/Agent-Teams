---
name: orchestrator
description: Make a project's main chat the orchestrator. Every task runs as its own worker (a cloud session, a Codex lane, or whatever the harness offers); workers report back when they pause, the orchestrator answers them until the task is done, merges their branches and closes them. Works on any model or harness that can start a worker and read its branch. Use when Jase says "be the orchestrator", "run it as a session", or when the project's AGENTS.md makes its main chat the orchestrator. Not for one-file checks, which stay in the main chat.
---

# Orchestrator

**The main chat keeps Jase, the decisions, the Forge and the merge; every task runs as its own worker.** The main chat stays short, so it never runs out of context, and each worker is visible on its own, where Jase can open it.

The steps below say what to do. "How each harness does it" at the end maps them to tools; a harness not listed does each step's intent with what it has.

## What becomes a worker

- A build lane, a review seat, a design round, a fix round, research, a migration dry run: anything that reads many files or runs long.
- Not: a file read, a Forge update, a commit, a reply to Jase, a check done in a few calls. Those stay in the main chat.
- Parallel workers own disjoint files, as lanes do. Only the orchestrator starts workers, so the tree stays one level deep.

## Start one

1. **Your address.** Find how a worker reaches the main chat (its session id, or a report path if the harness has no messaging). Every brief carries it.
2. **Start it** from the working branch, on its own branch `task/<task-slug>`. A worker never pushes the working branch or `main`, and two workers never share a branch.
3. **Pick its model and effort** as the project's AGENTS.md routes them. Never start a worker in a mode that waits for a person to approve a plan: nobody is watching it.
4. **Name it** `<Project>: <task>` and tag it with the project and the main chat's id, so Jase can find it.
5. **Record it** on the Forge the same turn: the work row gets `who: {model, role}` and the worker's link or id in `ref`.

## The brief

Every brief holds the task's goal, the files it owns, what done means and its gate, then these lines word for word with the names filled in:

> Read AGENTS.md first and follow it. Push only to `task/<task-slug>`, committing in small steps (`WIP ...`), so a dropped connection loses one step.
> Whenever you stop, for any reason (done, blocked, a decision you cannot make, a Red action, a failure you cannot fix), report to `<address>` with: status (done, blocked or decision), what you did, the test counts, the commit, and what you need. Then wait for the reply and carry on with it. If you cannot send messages, write the same report to `reports/task-<task-slug>.md` on your branch, push it, and end.
> Never ask Jase directly and never take a Red action: the orchestrator does both. Do not publish the Forge or any artifact.

## While they run

- **Reports arrive in the main chat.** Verify each claim against the branch (files, counts, a rerun) before relaying anything to Jase (`verify-before-done`).
- **Answer** with a ruling, the next step, or "done, stop". A decision only Jase can make goes on the Forge as an ask; relay his answer back.
- **Quiet workers.** A failure may announce itself; a clean finish may not. After starting a batch, schedule one check-in (about 60 minutes) and, when it fires, read each quiet worker's state and its branch. Never poll in a loop.

## Finish one

1. **Merge.** Fetch its branch, read the diff, merge it into the working branch, run the project's gate on the result, commit and push.
2. **Close it** once its branch is merged, or its report is accepted for a task with no code. Jase gave the standing go for closing finished workers on 24 Nov 2026.
3. **Log it.** The Forge row moves; a decision made along the way goes in MEMORY.md first.

## Limits

- **Connectors.** A worker may lack the main chat's connectors (an email or GitHub connector, the artifact tool). Live checks through them and every publish stay in the main chat.
- **Cost.** Each worker reads the repo afresh, so batch small tasks into one worker rather than opening many.

## How each harness does it

| Step | Claude Code, cloud | Claude Code, local | Codex |
|---|---|---|---|
| Your address | `get_session` with no id gives the main chat's session id | the main conversation (`SendMessage` to `main`) | none: the report file |
| Start | `create_session`: `source_url` the repo, `source_revision` the working branch, `outcome_branch` `task/<slug>`, `title`, `tags`, `model`, `effort`; `permission_mode` inherited | the Agent tool with `isolation: "worktree"`, `run_in_background: true` | the project's Codex lane script (for example `scripts/codex-lane.sh <slug> <brief file>`) (its own worktree and local branch) |
| Report | the worker's `send_message` to the main chat's id | the agent's final report | `reports/task-<slug>.md` on its branch |
| Answer | `send_message` to the worker's session id | `SendMessage` to the agent | a new lane run with the answer in its brief |
| Quiet check | `send_later` once; then `list_sessions` with `children: true` and each one's `status_bucket` | the harness notifies when the agent ends | the script returns when the run ends |
| Close | `archive_session` | nothing to close | remove its worktree |
