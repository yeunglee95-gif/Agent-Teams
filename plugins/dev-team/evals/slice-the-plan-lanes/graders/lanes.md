---
type: llm
focus:
  source: file
  path: plans/M5-plan.md
weight: 3
---

This is a milestone lane plan for: customer notes (add, show latest, edit or delete own; data, API and screen)
and a rename of `customerName` to `displayName` that touches about 40 files.

PASS only if all of the following hold:
1. The notes work is cut into vertical slices: at least one lane delivers a behavior end to end (data, API and screen together, for example "add a note"), rather than one lane per layer ("all the database work", "all the API work", "all the UI").
2. Each lane names the files it owns, and no file is owned by two lanes in the same wave.
3. Each lane names at least one red test it starts from (a test title or test file).
4. Each lane says what blocks it (or "none").
5. The rename is sequenced as expand (add the new name beside the old), migrate (callers moved in batches), then contract (remove the old name), as separate ordered steps or lanes.

FAIL if lanes are split by layer, if any lane lacks owned files, red tests or a blocked-by entry, or if the rename is a single big-bang lane.
