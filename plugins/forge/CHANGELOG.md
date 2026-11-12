# Changelog

## 0.1.0 (2026-11-12)

- First version, moved from Claude OS `00_Resources/forge/` at `13f1038`: renderer 1.4.1, schema 1.4, `forge.mjs`, the example, the build spec and the lifecycle map, unchanged apart from the two lines below. The `/forge` skill comes from Claude OS `.claude/skills/forge/SKILL.md` at the same commit.
- The skill's rule for when the board moves changed (Jase, 2026-11-12): only for asks, decisions and milestones, with live progress in the crew-progress status file, replacing the run after every completed task and deploy. Its paths now point at this plugin's `master/` folder.
- The build spec's folder section and decisions table, and the lifecycle map's master node, now name this plugin as the master.
- The master README became this plugin's `README.md`.
