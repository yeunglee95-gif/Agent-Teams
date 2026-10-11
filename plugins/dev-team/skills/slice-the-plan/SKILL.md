---
name: slice-the-plan
description: Use when turning an agreed plan or spec into lanes for a milestone. Cuts the work into thin vertical slices, each a lane with its own files and named red tests, orders lanes by what blocks what, sequences wide refactors as expand then migrate then contract, and has the owner check the breakdown before any lane starts.
---

# Slice the plan

Run this after the `grill-the-plan` skill has closed every open decision. The output is the lane plan the architect owns.

## 1. Read first

The agreed decisions, the spec sections the milestone claims, the app's architecture doc and file-ownership map, the contract files, the glossary and the decision records in the area. Use the glossary's words in lane titles. Look for a small refactor that would make the change easy; it goes first, as its own lane.

## 2. Cut vertical slices

Each slice is a tracer bullet: a narrow but complete path through every layer the behavior needs (data, logic, interface, tests), never one layer on its own.

- A finished slice can be shown or checked on its own.
- A slice fits in one fresh session of one lane.
- Refactoring that makes the slices easy comes first.

## 3. Make each slice a lane

For each lane, write:

- **What it delivers:** the behavior a person will see, in the spec's words, with the spec reference.
- **Files it owns:** from the ownership map. Lanes in the same wave own disjoint files; a file two lanes need belongs to one lane, and the other reads it through its export or waits.
- **Red tests it starts from:** each by file and title, asserting on the stable hooks the app's `CLAUDE.md` names. "Done" is these tests green in a gate the owner ran.
- **Blocked by:** the lanes that must finish first, or "none". Blocking edges are the lane order: lanes with nothing open ahead of them can run in parallel; a chain runs top to bottom.
- **Contract shapes** it may add, if any, pre-signed in the plan; anything else stops and asks the architect.

The plan also holds one lane table, beside any prose, because the owner, the board and the checks read it:

```
| Lane | Kind | Delivers | Owns | Red tests | Blocked by |
|---|---|---|---|---|---|
| N1 | slice | S5.1 add a note | `src/db/notes.ts`, `src/api/notes.ts`, `src/ui/NoteEditor.tsx` | `tests/notes.test.ts` > "adds a note" | none |
```

One row per lane, never a row for a group of lanes. Kind is `slice`, `expand`, `migrate` or `contract`. Owns lists file paths. Red tests are `file > test name` entries. Blocked by lists lane ids, or `none`.

Every lane delivers behavior and starts from at least one red test. Two kinds of work are not lanes: the contract change (the architect's contracts step, done in one commit before the lanes start) and the final full gate (the gate-runner's stage after the lanes). Put them in the plan as those steps, under their own heading, not as lanes or table rows; no lane lists a contract file among the files it owns.

## Wide refactors

A wide refactor is one mechanical change (rename a field, retype a shared type) that touches so many call sites that no vertical slice can land green. Do not force it into a slice. Sequence it as expand, migrate, contract:

1. **Expand:** add the new form beside the old, so nothing breaks.
2. **Migrate:** move callers over in batches sized by how far the change reaches (one package or folder per batch), each batch its own lane blocked by the expand, with the gate green after each.
3. **Contract:** delete the old form once nothing calls it, in a lane blocked by every migrate batch.

When the old form also lives in a contract file, that file stays the architect's: the new form goes in with the contracts step before the lanes, and the old form comes out in a second contracts step after the contract lane. The contract lane is still a lane: it deletes the old form from the code.

If even the batches cannot stay green alone, keep the order, put the batches on one integration branch, and promise green only at a final check lane they all block.

## 4. Owner check

Show the breakdown to the owner as a numbered list (title, blocked by, what it delivers) and ask:

- Is the size right: too coarse or too fine?
- Does each lane depend only on lanes that really gate it?
- Should any lanes be merged or split?

Change it until the owner approves it. Then the reviewer critiques the plan (the `architecture-critique` skill) before any lane starts.

## Where it goes

The lane plan goes where the app's `CLAUDE.md` says milestone plans live. Publish lanes to an issue tracker only if the `CLAUDE.md` names one, and then each item lands where the owner moves it on, never straight into a ready column. Keep exact file lists in the plan, not in the tickets, so there is one home for them.

## Source

Adapted from `skills/engineering/to-tickets/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. Changed: rewritten in this team's voice; tickets became lanes with disjoint file ownership and named red tests; blocking edges became lane order; the quiz step goes to the owner; the reviewer's plan critique added before lanes start; publishing to a tracker only when the app's `CLAUDE.md` names one, never with a ready-for-agent label; the setup-skill pointer and ticket templates removed. License text: `../../licenses/mattpocock-skills-MIT.txt`.
