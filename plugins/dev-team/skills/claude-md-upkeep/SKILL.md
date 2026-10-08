---
name: claude-md-upkeep
description: Use at the close of a milestone, and whenever an agent stopped to ask because the app's CLAUDE.md did not say something. Audits each CLAUDE.md against the code, reports a score and proposed changes, and applies only the changes the owner approves.
---

# CLAUDE.md upkeep

Every role reads the app's `CLAUDE.md` first. A stale one misleads the whole team at once, so it is kept current and short.

## 1. Find them

Every `CLAUDE.md` in the repo, the root one first.

## 2. Score each one

| Check | Points | Question |
|---|---|---|
| Commands | 20 | Are the build, test and gate commands there, and do they run as written? Run them. |
| Map | 20 | Does it name the memory file, specs, contracts, ownership map, ports and action tiers the roles rely on? |
| Gotchas | 15 | Are the non-obvious rules recorded (the ones agents stopped to ask about)? |
| Short | 15 | Nothing obvious from the code, no long explanations, no copies of facts that live elsewhere? |
| Current | 15 | Does every path, command and name it gives still exist? |
| Actionable | 15 | Is every rule something an agent can follow or check, not a wish? |

## 3. Report before changing anything

Score per file, the problems found, and each proposed change as a quoted addition or removal with one line on why it helps the next session. Sources for additions: questions agents had to ask this milestone, commands that did not work as written, gotchas found in review.

## 4. Apply only what the owner approves

Edit only the approved changes and keep the file's structure. Link to where a fact lives rather than copying it in. Log the change in the memory file.

## Source

Adapted from the `claude-md-improver` skill in Anthropic's `claude-md-management` plugin (anthropics/claude-plugins-official, Apache License 2.0), commit b78ac49cdc6b3d7b61c4439470e311f4291265b1. Changed: rewritten in this team's voice, the scoring tied to what this team's roles need from a `CLAUDE.md`, and the sources for additions named. License text: `../../licenses/Apache-2.0.txt`.
