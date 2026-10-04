# Agent Teams

Jase's agent teams, in one private repo. Each team is a Claude Code plugin with its own version, and the repo is a plugin marketplace that lists them. The dev team is the first. Why it is set up this way is recorded once, in OS Flow's `MEMORY.md` (repo yeunglee95-gif/os-flow) (Decisions, 2026-10-04, agent teams); this file does not restate it.

## Layout

```
.claude-plugin/marketplace.json    lists every team
plugins/
  dev-team/
    .claude-plugin/plugin.json     name and version
    agents/                        one file per role
    CHANGELOG.md                   what changed in each version
```

## Add a new team

1. Make `plugins/<team>/` with `.claude-plugin/plugin.json` (name and version 0.1.0), `agents/` and `CHANGELOG.md`.
2. Add the team to the `plugins` list in `.claude-plugin/marketplace.json`, with `source` set to `./plugins/<team>`. The name there matches the name in `plugin.json`.
3. Run `claude plugin validate .` and commit.

Do not make a team's folder until the team has roles in it.

## How an app uses a team

- **Install it.** In the app's Claude Code session: `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install dev-team@agent-teams`.
- **Or copy it.** Where a cloud session cannot install plugins, copy `plugins/dev-team/agents/*.md` into the app's `.claude/agents/` from one pinned commit of this repo, and record that commit in the app's `routine/TEAM-VERSION.md`.

Each app keeps its own memory, specs, gate commands and specialists (personas, rubrics, domain reviewers) in its own repo. The roles read the app's `CLAUDE.md` for all of these and stop to ask when it does not say.

A pin changes only between milestones, so a team change cannot break an app's loop mid-milestone.

## Rules for this repo

- A team moves to its own repo only when someone outside needs access to that team alone (GitHub access is per repo).
- Business knowledge is linked, never copied. It stays in each business's own repo and Notion.
- No credentials anywhere in this repo.
