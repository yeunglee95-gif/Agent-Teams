# Changelog

## 0.3.1 (2026-11-20)

- Renderer 1.5.1: open asks group under Answer now, Answer soon and Answer later, in id order inside each group, so the numbers no longer jump (Jase, 2026-11-20). A Jump to row lists every open id; a tap opens its fold and scrolls to it. An overdue default keeps its tag and the banner instead of moving to the top. The ROADMAP block uses the same order.

## 0.3.0 (2026-11-20)

- Renderer 1.5.0: every open ask shows its steps unfolded under What to do, with a link button on each step that has a page (Jase, 2026-11-20). A decision's options become step 1 and a look's names step 1; the last step is the reply, linking the build chat. The reasoning folds under "Why we suggest this", a default reads "If you do nothing", and the never-paste-a-password note shows only on steps that mention a password, secret, key or token.
- Asks are written in the caveman voice: a title of 10 words or fewer, a `why` of two sentences at most, every sentence 20 words or fewer, no em dash (build spec 5.2). `check` warns on each breach.
- `check`'s sentence counter skips abbreviations such as "e.g." and counts a stop before a closing quote or bold mark. Older guides that end in an unlinked "reply in the build chat" step get the chat link, and get no second reply step.
- `update` now copies the `/forge` skill from this plugin into the project's `.claude/skills/forge/`; it had looked only in the old Claude OS layout, so project copies went stale. A project on 1.4.x runs `update` twice: the first run still uses its old script, which skips the skill.

## 0.2.0 (2026-11-12)

- Renderer 1.4.2: the stale banner shows only while an open ask's default date has passed, and names those asks, instead of after 24 hours (Jase, 2026-11-12). Under the move rule a quiet board is current, so the age banner misled. The stamp still shows the board's age. `check` drops its 24-hour warning; its overdue-default warning covers the new rule.
- The renderer's head comment names this plugin as the master.

## 0.1.0 (2026-11-12)

- First version, moved from Claude OS `00_Resources/forge/` at `13f1038`: renderer 1.4.1, schema 1.4, `forge.mjs`, the example, the build spec and the lifecycle map, unchanged apart from the two lines below. The `/forge` skill comes from Claude OS `.claude/skills/forge/SKILL.md` at the same commit.
- The skill's rule for when the board moves changed (Jase, 2026-11-12): only for asks, decisions and milestones, with live progress in the crew-progress status file, replacing the run after every completed task and deploy. Its paths now point at this plugin's `master/` folder.
- The build spec's folder section and decisions table, and the lifecycle map's master node, now name this plugin as the master.
- The master README became this plugin's `README.md`.
