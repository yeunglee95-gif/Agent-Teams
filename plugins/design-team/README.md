# Design team

Three roles that design an app's screens, check what was built against them and judge the design itself, for any app, reading the app's own `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet) and design system for its specifics. The app's design system (for OS Flow, Capsule in `docs/design/CAPSULE-DESIGN.md`) always wins over any skill's taste.

## The roles

| Role | Does | Never |
|---|---|---|
| `designer` | Extends the app's design system (tokens in three layers, day and night), designs screens and writes the design hand-off the dev team builds from; sets visual direction for marketing pieces (landing pages, email templates, ads) when asked. | Writes app code; replaces the design system (a change to it is a proposal for the owner); writes outside the hand-off folder its brief names; sends or publishes anything. |
| `design-critic` | Judges the design itself from the milestone's screenshots, before reading the hand-off: each page's main job, layout, competing controls, consistency and usability. Runs the critique on ChatGPT `gpt-6.2-astra` through `codex exec` on the owner's ChatGPT plan and checks each finding against its screenshot, or runs it on Claude and says so. Method: the `design-critique` skill. | Edits or fixes anything; reads the hand-off before its first impressions are written; falls back to Claude without naming it on the report. |
| `design-auditor` | Checks the built screens against the hand-off and the design system: craft, accessibility (WCAG 2.2 AA) and motion, one report with severity, evidence and the rule each finding breaks. | Edits or fixes anything (findings go to the dev team's fixer); raises a skill's taste as a finding where the design system says otherwise (it notes the conflict instead). |

One skill of the team's own, `design-handoff`, says what a hand-off holds; both roles preload it.

## How it works with the dev team

For a milestone that changes screens, the dev team's loop (`plugins/dev-team/workflows/milestone-loop.md`, dev-team 0.6.0) has a stage and a part of a stage for this team:

1. **Design**, after Plan and slice and before Build: the designer writes the hand-off. Gate: the owner approves it.
2. The dev team builds to the hand-off. A gap in the design goes back to the designer; a lane never invents it.
3. **Design check**, in the dev team's Review stage: the design-auditor writes its report in its own context, at the same time as the dev team's spec-auditor, critic, security-reviewer and reviewer. The reviewer folds its findings into the one combined findings table (tagged `design-auditor D<N>`). The fixer fixes; the design-auditor re-checks its findings by id after each fix round, at most two rounds. A blocker or major still open after round 2 goes to the owner.

Both are skipped for a milestone with no screen change. The owner (Jase, unless the app's `AGENTS.md` names someone else) gives every merge, deploy, send and publish go; the one exception is a merge the dev team's approver makes under an app's opt-in auto-merge setting, which never covers sending or publishing.

The designer also serves marketing: a landing page, an email template or an ad gets a direction note and mocks from the app's design system first. Nothing goes out without the owner's go.

## Skills: referenced, not copied

The roles use five design skills that live on Jase's claude.ai account: `impeccable`, `ui-ux-pro-max`, `design-system`, `emil-design-eng` and (from 0.2.0, designer only) `frontend-design`. They are not copied into this plugin (sizes, scripts and a missing license; see `THIRD_PARTY.md` for what each file shows and which role uses it for what). Each role lists them by plain name in its `skills:` frontmatter, and Claude Code preloads them from the account. Each skill has one job per role so findings do not repeat. Where a skill is not available (another account, an eval sandbox), the role works from its own text: the design-auditor carries a core checklist for exactly that case.

Checked on Claude Code 2.1.296 on 2026-10-10, with throwaway agents in a scratch plugin run as subagents from `claude -p`: the `--debug-file` log showed `Preloaded skill 'impeccable'` for the plain name and `Preloaded skill 'anthropic-skills:impeccable'` for the full name, all four plain names preloaded in one agent, and a name that does not exist logs `Skill '<name>' specified in frontmatter was not found` and the agent still runs. The Skill tool also loads them on demand by plain name (`SkillTool returning 2 newMessages for skill anthropic-skills:design-system`).

Skills read and not taken are in `skills/REJECTED.md`.

## Load the plugin

- **Install it.** In the app's Claude Code session: `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install design-team@agent-teams`. The roles are then `design-team:designer`, `design-team:design-auditor` and `design-team:design-critic`.
- **Or copy it.** Where plugins do not install from a repo's settings (cloud sessions), copy `agents/*.md` into the app's `.claude/agents/` and `skills/design-handoff/` and `skills/design-critique/` into the app's `.claude/skills/`, from one pinned commit of this repo, recorded in the app's `routine/TEAM-VERSION.md`, as for the dev team. The four account skills still come from the account.
- To try it from a checkout of this repo: `claude --plugin-dir plugins/design-team`.

## Evals

Behavior evals for the design-auditor and the design-critic are in `evals/<case>/` (`case.yaml`, `prompt.md`, `seed.sh`, `graders/`), in the dev team's format. Each seeds a tiny static app with a `DESIGN.md` and a hand-off, plants defects, and grades the report and that no seeded file changed. Run them from the repo root:

```
claude plugin eval plugins/design-team -j 3 --scaffold --allow-tools Bash Write Edit --ablation none --judge-model sonnet --no-publish --trust-plugin
```

`design-critique-planted` plants three design problems its own hand-off asks for, and checks that the design-critic reports them anyway, writes first impressions first, and names its Claude fallback, because the sandbox has no Codex. The cases do not rely on the account skills, since the eval sandbox may not have them; they pass from the role's own text. Results land in `evals/results/`, which is not committed.
