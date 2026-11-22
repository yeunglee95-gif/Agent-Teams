# design-team changelog

## 0.4.1 (2026-11-22)

- Two ideas from oil-oil/oil-ui at `eebeee4` (MIT), rewritten, no text copied (Jase, 2026-11-22). `design-critique`: after its first impressions and before the hand-off, the design-critic walks the running app blind, picks the main path itself and logs where it got stuck, took a wrong turn or hesitated (at most three findings), or writes `Walk: static only`. `design-handoff`: each screen's Purpose names its one main element and main action per key state, and how every other action is demoted.
- `oil-ui` as a whole skill and `Awwwards-mcp` are in `skills/REJECTED.md`.
- The design-critic and design-auditor always write their report at its named path inside the app: in the eval sandbox a refused scratch write outside it made both conclude they could not write at all and leave the report only in their reply. The walk gives a browser at most two tries before `Walk: static only`.
- Evals on 2026-11-22 (Claude Code 2.1.330, one run at a time): `design-critique-planted`, `design-audit-planted` and `design-audit-taste-conflict` each 3 of 3. Before the report-path fix, the critique case failed 3 of 3 the same way.

## 0.4.0 (2026-11-21)

- New role `design-critic` and its skill `design-critique` (Jase, 2026-11-21). In the dev team's Review stage, when screens change, it judges the design itself from screenshots (each page's main job, layout, competing controls, consistency, usability) and writes first impressions before it reads the hand-off. It runs the critique on ChatGPT `gpt-6.2-astra` through `codex exec` on the owner's ChatGPT plan and checks each `K<N>` finding against its screenshot; without that route it runs the method on Claude and names the fallback on its report's Model line. The method is OS Flow's own, which now has its one home here.
- New eval `design-critique-planted`: three design problems its own hand-off asks for (three doors to one action, a page that copies another, an empty page). On 2026-11-21 (Claude Code 2.1.330, judge sonnet) it passed 3 of 3: every run reported all three with severity, wrote first impressions first, named its Claude fallback (no Codex in the sandbox) and changed no file.

## 0.3.0 (2026-10-31)

- Works with dev-team 0.10.0. The designer, the design-auditor, the `design-handoff` skill and `README.md` read the app's `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet), the file apps are moving their rules to (owner's decision, 2026-10-31). Both roles' never-edit lists protect `AGENTS.md` (or `CLAUDE.md`). No other change. Eval seeds still write a `CLAUDE.md`, so they exercise the fallback.
- Evals, 2026-10-31 (Claude Code 2.1.316, judge sonnet, Linux sandbox, harness run as root), 3 runs each: `design-audit-taste-conflict` 3 of 3; `design-audit-planted` 2 of 3, re-run with `--keep-temp` 2 of 3 again; $4.41 both. Read the failing trace: as root the sandbox makes `$TMPDIR` and home read-only, so every run's mkdir for a screenshot scratch folder fails. The passing runs then wrote the report with Write, which worked. The failing run tried no Write: it decided the sandbox blocked all writes and returned the report in its reply (all six planted defects found, verdict fix-required, nothing edited). Sandbox-triggered, the same class as dev-team's root-only misses, but the role gave up on its report without trying it. Open for the owner: whether the auditor's text should say to try writing the report even after a scratch write fails.
- With the seeds switched to `AGENTS.md` on a scratch branch (not merged), 1 run each: `design-audit-taste-conflict` 1 of 1, `design-audit-planted` 0 of 1, the same no-Write miss; both read `AGENTS.md` first. $1.01.

## 0.2.1 (2026-10-25)

- The design-auditor's report ends with the dev team's Coverage line (dev-team 0.9.0): the head, the screens, states, targets, themes and languages it checked, and what it did not reach. No eval run for this line alone.

## 0.2.0 (2026-10-18)

- The designer preloads `frontend-design` from Jase's account (owner's decision, 2026-10-18), with two fixed jobs: its two-pass plan (4 to 6 named colors, type roles, a layout concept and principles, reviewed against the brief and revised where it reads as a default) for marketing pieces, and its list of generated-look defaults as a self-check on every screen before hand-off. The app's design system wins on every axis it settles; the skill's "take aesthetic risk" applies only to what the design system and the brief leave free. The design-auditor does not load it. `skills/REJECTED.md` records why the 2026-10-10 rejection no longer holds; `THIRD_PARTY.md` records its license as found (Apache License 2.0 in `LICENSE.txt`, no version).
- Evals (design-auditor, unchanged role): `design-audit-planted` 2 of 2, `design-audit-taste-conflict` 2 of 2, $1.64. No case covers the designer yet.

## 0.1.1 (2026-10-11)

- Works with dev-team 0.6.0, whose loop runs the design check inside its Review stage, at the same time as the spec-auditor, critic, security-reviewer and reviewer, each in its own context. The `design-auditor` description and its "Where you sit" line now say so; its findings reach the fixer through the reviewer's combined findings table and it re-checks them by id after each fix round, at most two rounds. `README.md` updated to match. No change to the checklist, the report or the skills.

## 0.1.0 (2026-10-10)

First release. Scope approved by the owner on 2026-10-10.

- Roles: `designer` (opus; design system work, screen designs and the hand-off, marketing direction when asked; writes only in the hand-off folder its brief names) and `design-auditor` (opus; read-only; craft, WCAG 2.2 accessibility and motion checked against the hand-off and the app's design system; a core checklist in its own text so it works without the account skills).
- Skill of our own: `design-handoff` (what a hand-off holds, per screen: states, tokens used, motion, accessibility, copy and acceptance notes; proposals to the design system go to the owner).
- Referenced, not copied: `impeccable` (4.1.1), `ui-ux-pro-max`, `design-system` (1.0.0, MIT, claudekit) and `emil-design-eng`, from Jase's account, each with one job per role (`THIRD_PARTY.md`).
- Not taken: `high-end-visual-design`, `design-taste-frontend`, `frontend-design`, `ui-styling` (`skills/REJECTED.md`).
- Works with dev-team 0.4.0, whose loop gains the Design and Design check stages for milestones that change screens.
- Checked on Claude Code 2.1.296: account skills preload by plain name from a plugin agent's `skills:` list (`Preloaded skill 'impeccable'` in the `--debug-file` log); a missing one logs a warning and the agent still runs.
- New: `evals/`, cases for the design-auditor.
