# Changelog

## 0.6.0 (2026-11-24)

- Added `orchestrator`: the main chat keeps Jase, the decisions, the Forge and the merge, and every task runs as its own worker (a cloud session, a local background agent or a Codex lane) that reports back until done, then is merged and closed. Written by Jase.

## 0.5.0 (2026-11-23)

- Added `decide`: weigh a choice the way the project's owner does (aspects, pros and cons, one recommendation) and present it the way they read it. The owner's principles, overrides and replay cases stay in each project's `context/decide/`, with formats in `skills/decide/templates/`; `evals/decide/run.py` scores a model with and without the skill. Written by this team, from a-271 (a).

## 0.4.0 (2026-11-22)

- Added `obscura` skill: headless browser for AI agents and web scraping via the Obscura CLI. Written by this team.

## 0.3.0 (2026-11-20)

- Added `agent-browser` skill: browser automation for AI agents via the agent-browser CLI. Written by this team.

## 0.2.0 (2026-11-12)

- Added `caveman` (juliusbrussee/caveman core skill, Apache 2.0), unchanged apart from a Source section.

## 0.1.0 (2026-11-12)

- First version: `watch` (claude-video 0.3.2) and `find-skills` (vercel-labs/skills), both MIT, unchanged apart from a Source section.
