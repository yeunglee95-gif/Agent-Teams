# Changelog

## 0.2.0 (2026-11-12)

- Renderer 1.4.2: the stale banner shows only while an open ask's default date has passed, and names those asks, instead of after 24 hours (Jase, 2026-11-12). Under the move rule a quiet board is current, so the age banner misled. The stamp still shows the board's age. `check` drops its 24-hour warning; its overdue-default warning covers the new rule.
- The renderer's head comment names this plugin as the master.

## 0.1.0 (2026-11-12)

- First version, moved from Claude OS `00_Resources/forge/` at `13f1038`: renderer 1.4.1, schema 1.4, `forge.mjs`, the example, the build spec and the lifecycle map, unchanged apart from the two lines below. The `/forge` skill comes from Claude OS `.claude/skills/forge/SKILL.md` at the same commit.
- The skill's rule for when the board moves changed (Jase, 2026-11-12): only for asks, decisions and milestones, with live progress in the crew-progress status file, replacing the run after every completed task and deploy. Its paths now point at this plugin's `master/` folder.
- The build spec's folder section and decisions table, and the lifecycle map's master node, now name this plugin as the master.
- The master README became this plugin's `README.md`.
