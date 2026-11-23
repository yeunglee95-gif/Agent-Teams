# Calibration: where Jase picked against the recommendation

An override is the strongest signal this skill gets, because it shows where the method was wrong. Read the overrides for the kind of choice in front of you before recommending; an override beats a principle on the case it covers.

## Format

One entry per override, newest first:

```
### YYYY-MM-DD, <project> <ask id>: <the question in a few words>
- Recommended: <option and its one-line reason>
- Picked: <option>
- His words: "<quote, or 'none given'>"
- Principle change: <which principle in principles.md moves, is added or is narrowed, or 'none'>
```

Also log a decision where he agreed with the recommendation but gave a reason the principles do not hold yet, with "Picked: same" and the new reason.

## Overrides

None seeded yet. They come from OS Flow's `forge/forge.json` (the recommendation he was shown and his outcome) once that log is read.

## How projects feed overrides in

Projects copy this skill from a pinned commit and cannot write to Agent-Teams, so each project keeps its own log.

1. **Each project keeps `decide-overrides.md`** beside its memory file, in the format above. The session that logs a decision adds the override the same turn.
2. **On each re-vendor** (when the project moves its pinned commit), the session that does it opens a branch here, folds the project's new entries into § Overrides above with the project's name, and updates `principles.md` where an entry says a principle changes. The project then marks those entries "folded, <commit>" so they are not folded twice.
3. **A held-out replay case** in `plugins/toolkit/evals/decide/cases.jsonl` is never folded in as evidence; if an override repeats one, add the override and drop the case from the hold-out set.
