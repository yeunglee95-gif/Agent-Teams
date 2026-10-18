# design-team changelog

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
