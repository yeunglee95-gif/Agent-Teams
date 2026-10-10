# design-team changelog

## 0.1.0 (2026-10-10)

First release. Scope approved by the owner on 2026-10-10.

- Roles: `designer` (opus; design system work, screen designs and the hand-off, marketing direction when asked; writes only in the hand-off folder its brief names) and `design-auditor` (opus; read-only; craft, WCAG 2.2 accessibility and motion checked against the hand-off and the app's design system; a core checklist in its own text so it works without the account skills).
- Skill of our own: `design-handoff` (what a hand-off holds, per screen: states, tokens used, motion, accessibility, copy and acceptance notes; proposals to the design system go to the owner).
- Referenced, not copied: `impeccable` (4.1.1), `ui-ux-pro-max`, `design-system` (1.0.0, MIT, claudekit) and `emil-design-eng`, from Jase's account, each with one job per role (`THIRD_PARTY.md`).
- Not taken: `high-end-visual-design`, `design-taste-frontend`, `frontend-design`, `ui-styling` (`skills/REJECTED.md`).
- Works with dev-team 0.4.0, whose loop gains the Design and Design check stages for milestones that change screens.
- Checked on Claude Code 2.1.296: account skills preload by plain name from a plugin agent's `skills:` list (`Preloaded skill 'impeccable'` in the `--debug-file` log); a missing one logs a warning and the agent still runs.
- New: `evals/`, cases for the design-auditor.
