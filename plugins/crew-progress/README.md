> **A fork** of [savvy-progress](https://github.com/johnnyvizz/claude-kit/tree/main/plugins/savvy-progress) in johnnyvizz/claude-kit at `af8902c` (MIT), first made for OS Flow (2026-11-12) and kept in Agent-Teams for every project. Install it with `/plugin install crew-progress@agent-teams`. What changed from upstream:
> - Codex's tasks sit beside Claude's subagents, read from Codex's own session logs, with the ChatGPT plan's 5-hour and weekly limits.
> - Each agent wears its role's costume, and a Codex task wears the same one on a teal terminal body.
> - The crew's state is also written as text to a status file, for screens that draw no panel.
> - The command is `/crew` and the tools are `mcp__crew-progress__progress` and `mcp__crew-progress__step`.
> - Paths come from the user's home (`HOME`, or `USERPROFILE` on Windows); `tests/paths.test.ts` checks it. The upstream tests are not copied, because they test savvy-progress's names and panel.
>
> Changes by version: `CHANGELOG.md`.

# crew-progress

A Claude Code mod: a progress bar above the prompt and a live crew panel that shows Claude's subagents and Codex's tasks side by side, each with its model, task progress, context, estimated cost and time.

- **Progress bar**: the flow's title, phase, accepted tasks out of planned, and a button with the crew size that opens the panel.
- **Crew panel** (`/crew` toggles it; `/crew open` opens it or brings it forward without toggling): running, finished and planned subagents, then Codex's recent tasks and its plan limits. `prefers-reduced-motion` stops the animations.
- **Status file**: `~/.claude/state/crew-progress/status.md`, rewritten every 5 seconds when it changes. It lists the running and recently finished Claude agents and Codex tasks, the spend at API prices and the ChatGPT plan limits. A cloud session watched in the Claude app draws no panel, so the orchestrator quotes this file for live progress.

## Role costumes

`ROLE_COSTUME` in `hooks/register.tsx` gives each role a costume and an accent colour: the dev-team and design-team roles in this repo (`plugins/dev-team/agents`, `plugins/design-team/agents`) plus Claude Code's built-in Explore and Plan. **Every new role gets a costume there in the same change that adds the role**; a role without one draws plain.

## Codex

Codex writes its sessions to `~/.codex/sessions/YYYY/MM/DD/*.jsonl`. The mod reads the five newest logs in the two newest day folders every 5 seconds. A task's role comes from its brief ("as the fixer", `.codex/agents/reviewer.toml`), and a log that has not moved for ten minutes counts as finished.

## Tools it adds

- `mcp__crew-progress__progress`: the orchestrator reports the plan, phase and accepted tasks. Only the main session can; a call from a subagent is ignored.
- `mcp__crew-progress__step`: a worker reports its own steps (`done`, `total`, `note`). A worker that does not report shows its context fill in grey instead.

Cost is a rough estimate from token counts and a built-in per-model price table (`PRICES` in `hooks/register.tsx`), not a bill.

## Settings

`language`: `auto` (default), `en`, `ru` or `he`. `auto` follows Claude Code's `language` setting, then the system locale, and falls back to English.

`autoOpen`: `any` (default) opens the panel once per session when any subagent starts; `savvy` opens it only for a `savvy-*` worker or a reported plan.

## Develop

```sh
claude plugin validate .
claude plugin test .
```
