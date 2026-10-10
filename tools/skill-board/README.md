# Skill board generator

Builds a team's pages straight from its plugin folder, so nothing on them is typed by hand. Each page is one self-contained HTML file to open in a browser or publish as a private page.

| Template | Page | Status |
|---|---|---|
| `workspace-template.html` | **Team room, Workspace mode.** Three sub-pages share the teams panel: Roster (on the roster and the skill matrix), Skill shelf (search, filter, sources, turned down) and Workflow (the loop as a factory board with a travelling work item). Capsule design. | Design reference for OS Flow spec 16 §3.4 |
| `tea-room-template.html` | **Team room, Tea room mode.** The animated room: agents rest, pick up a cup for each skill and walk to the work floor. | Later, before launch |
| `skill-board-template.html` | **Skill board.** Roles wired to skills, sources, the loop and the rejected list. | The first static board |

## Run it

From the repo root, for any branch or commit:

```
python3 -I tools/skill-board/gen.py . main plugins/dev-team tools/skill-board/workspace-template.html out/team-room.html
```

The arguments are the repo, the git ref, the plugin folder, the template and the output file. The script prints a count and any **map issues** it found. A map issue is a gap in the team repo, not in the page: a skill with no `## Source` section, a skill missing from `THIRD_PARTY.md` (a skill whose Source says "Written by this team" is the team's own), a role that loads a skill that is neither in `skills/` nor in the "Referenced, not copied" table, or a skill no role loads. Fix it in the repo and run again.

Write output under `out/`, which is ignored. Generated pages are not committed, because they would go stale the moment a skill changes.

## What it reads

Only through `git show` and `git ls-tree` at the ref you name, so your working tree is never touched:

- `.claude-plugin/plugin.json`: name and version
- `agents/*.md` frontmatter: name, description, model, tools, `skills:`
- `skills/*/SKILL.md`: frontmatter, title, first paragraph, and the `## Source` section ("Changed:" line)
- `THIRD_PARTY.md`: the sources table (repo, path, commit, license), and the skill names in its "Referenced, not copied" table (skills used from Jase's account by name, not shipped)
- `skills/REJECTED.md` or `REJECTED.md`: the turned-down table
- `workflows/milestone-loop.md`: the first table (the stages). The Workflow board groups stages into columns by the table's Phase column, in order of first appearance, and finds the fix loop ("Fix and re-verify" back to "Review") and the loop back to intake by stage name. A table without a Phase column keeps the old fixed columns when it has 14 rows, and otherwise shows all stages in one column.
- `licenses/` and `evals/`: counts only

The repo link comes from the `origin` remote.

## What is not real yet

The work states in the Team room templates (who needs you, who is running, the travelling dot) are **example states** written into the templates, and every page says so. They become real when OS Flow runs teams (spec/13). The other teams in the Workspace teams panel (marketing, finance, sourcing, ops) are planned, with nothing built yet.
