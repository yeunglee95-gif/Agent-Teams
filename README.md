# Agent Teams

Jase's agent teams, in one private repo. Each team is a Claude Code plugin with its own version, and the repo is a plugin marketplace that lists them: the dev team and the design team. Why it is set up this way is recorded once, in OS Flow's `MEMORY.md` (repo yeunglee95-gif/os-flow, Decisions, 2026-10-04); this file does not restate it.

## Layout

```
.claude-plugin/marketplace.json    lists every team
plugins/
  dev-team/
    .claude-plugin/plugin.json     name and version
    agents/                        one file per role (who)
    skills/                        one folder per skill (how); roles preload them
    skills/REJECTED.md             outside skills read and not taken, and why
    workflows/milestone-loop.md    the order of stages every role follows (when)
    evals/                         one behavior eval per new or changed skill
    evals/ROUTING.md               why each role runs on its model and effort, with the evidence
    evals/routing-log.md           cheaper setups that failed their eval (the miss log)
    licenses/, THIRD_PARTY.md      sources and licenses of adapted skills
    CHANGELOG.md                   what changed in each version
  design-team/
    .claude-plugin/plugin.json     name and version
    agents/                        designer and design-auditor
    skills/design-handoff/         the team's own skill: what a hand-off holds
    skills/REJECTED.md             design skills read and not taken, and why
    evals/                         behavior evals for the design-auditor
    THIRD_PARTY.md                 the account skills it references, not copies
    README.md, CHANGELOG.md
```

## The dev team

Ten roles and fourteen skills (0.5.1). Each role preloads only the skills it needs, listed in its agent file. Every role follows one loop, `plugins/dev-team/workflows/milestone-loop.md`, owned by the scribe: intake, grill the plan, plan and slice, design, pre-flight per lane, build lanes, gate, spec check, black-box check, design check, review, fix and re-verify, release check, the owner's go, retro, watch. Design and design check are the design team's stages and run only for a milestone that changes screens. The owner gives every merge and deploy go; nothing in the loop merges on its own.

The loop page's Sessions section sets how sessions map to milestones: one main session per milestone with its model fixed for its life (a model switch drops the prompt cache; an effort change keeps it), reading delegated to a few substantial subagents, a claim row on the roadmap's claim board before any lane starts, a cross-milestone pre-flight against other milestones' claimed paths and open pull requests, a retry cap, and a close with a handoff note so the next milestone starts in a fresh session. The retro (`run-retro`) also reads what each stage cost and names the most expensive one.

### Models

Each role's `model` is set from eval evidence, recorded in `plugins/dev-team/evals/ROUTING.md` with the method, the date and the Claude Code version: as of 0.5.1 the fixer, scribe and gate-runner run on `sonnet`, and the architect (held on opus until a plan-quality bake-off decides), owner, reviewer, spec-auditor, critic, security-reviewer and repo-auditor on `opus`. A cheaper setup is proposed only with eval evidence by that method, never switched mid-session, and one that failed goes in `routing-log.md` so it is not proposed again.

### Evals

Each new or changed skill has a behavior eval in `plugins/dev-team/evals/<case>/` (`case.yaml`, `prompt.md`, `seed.sh`, `graders/`). Each case seeds a small throwaway app, runs one role with the plugin loaded, and grades what it did. Run them from the repo root:

```
claude plugin eval plugins/dev-team -j 4 --scaffold --allow-tools Bash Write Edit Agent --ablation none --judge-model sonnet --no-publish
```

`--scaffold` runs each case's `seed.sh` (bash in this repo); `--allow-tools` grants the tools the cases list; `--judge-model sonnet` because the default judge was noisy on plan-length files. Cases that grant a shell need the eval sandbox (on Linux, `bubblewrap` and `socat`); without it every run is refused. Most checks are deterministic (regex over the output files and the run trace, and tool use); each LLM judge answers one short question. On 0.4.1 the full suite passed 26 of 27 runs, twice, and the three reworked cases passed 6 of 6 (`design-it-twice`), 12 of 12 (`slice-the-plan-lanes`) and 11 of 12 (`root-cause-red-first`). On 0.4.2 `spec-audit-test-gap` moved to regex checks over its fixed-shape test-gap table and passed 12 of 12, and the full suite passed 26 of 27. The new `owner-builds-to-handoff` case runs the owner as a subagent on a designed screen with a gap in its hand-off, and passed 12 of 12. On 0.5.0 two cases check the new session and cost rules: `retro-cost-view` (the scribe's retro names the most expensive stage, proposes no model change without eval evidence and does not repeat a logged failure) and `claim-before-lane` (the owner writes its milestone's claim row and holds a lane whose files another milestone claims). Both passed 6 of 6, and the full 0.5.0 suite passed 33 of 36. Without `--model`, the harness runs the main session on `sonnet`; add `--model opus` to measure a main-session role on opus (see `evals/ROUTING.md`). Expect an occasional failed run on `root-cause-red-first` when the fixer writes its hypotheses only after the fix (a real skip that the trace check catches), and on the cases that still use one long judge (`grill-the-plan-asks`, and the findings judge in `reviewer-hypotheses-first`, which failed once on 0.4.2 when a finding had no class label); read the output before changing a skill. Add `--case <name>` for one case, or `--runs 1 --keep-temp` to debug. Results land in `plugins/dev-team/evals/results/`, which is not committed. A skill edit runs its own case and the cases of every role that loads it, before and after, and the proposal shows both.

## The design team

Two roles (0.1.0): the `designer` extends the app's design system and writes the design hand-off the dev team builds from, and also sets visual direction for marketing pieces when asked; the `design-auditor` checks the build against the hand-off and the design system, read-only, with findings going to the dev team's fixer. They run the Design and Design check stages of the dev team's loop. Four design skills on Jase's claude.ai account (`impeccable`, `ui-ux-pro-max`, `design-system`, `emil-design-eng`) are referenced by name, not copied; `plugins/design-team/THIRD_PARTY.md` records what each file shows and which role uses it for what. The app's own design system always wins over any skill's taste. How the team works and how to run its evals: `plugins/design-team/README.md`.

## Add a new team

1. Make `plugins/<team>/` with `.claude-plugin/plugin.json` (name and version 0.1.0), `agents/`, `skills/` if the roles need any, and `CHANGELOG.md`. A skill adapted from a published source records its source, commit, license and changes in its own `## Source` section and in `THIRD_PARTY.md`, with the license text in `licenses/`. A skill the team writes says "Written by this team" in its `## Source` section. A skill used from Jase's account without copying it goes in a "Referenced, not copied" table in `THIRD_PARTY.md`.
2. Add the team to the `plugins` list in `.claude-plugin/marketplace.json`, with `source` set to `./plugins/<team>`. The name there matches the name in `plugin.json`.
3. Run `claude plugin validate .` and commit.

Do not make a team's folder until the team has roles in it.

## How an app uses a team

- **Install it.** In the app's Claude Code session: `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install dev-team@agent-teams` (and `/plugin install design-team@agent-teams` for an app with screens).
- **Or copy it.** Cloud sessions do not install plugins from a repo's settings, so there copy `plugins/dev-team/agents/*.md` into the app's `.claude/agents/` and `plugins/dev-team/skills/*` into the app's `.claude/skills/`, from one pinned commit of this repo, and record that commit in the app's `routine/TEAM-VERSION.md`. Copy `licenses/`, `THIRD_PARTY.md` and `workflows/` alongside, into `.claude/agent-teams/`, and name `.claude/agent-teams/workflows/milestone-loop.md` in the app's `CLAUDE.md` as the copy of the loop page.

Each app keeps its own memory, specs, gate commands and specialists (personas, rubrics, domain reviewers) in its own repo. The roles read the app's `CLAUDE.md` for all of these and stop to ask when it does not say.

A pin changes only between milestones, so a team change cannot break an app's loop mid-milestone.

## Rules for this repo

- A team moves to its own repo only when someone outside needs access to that team alone (GitHub access is per repo).
- Business knowledge is linked, never copied. It stays in each business's own repo and Notion.
- No credentials anywhere in this repo.
