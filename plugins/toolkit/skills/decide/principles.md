# Jase's decision principles

Ranked: when two conflict, the higher one wins. Each line is the principle, then its evidence as decision dates or ask ids with a short quote. Decisions held out for the replay test (`plugins/toolkit/evals/decide/cases.jsonl`) are never used as evidence here.

**Status: draft 0.** Built from this repo's `MEMORY.md` only. The OS Flow decision log, where most of his decisions live, has not been read yet, so the ranking and the principles marked "unverified" wait for that pass.

1. **Never lose his work or data, and never clear or send anything without his permission.** Unverified: OS Flow 2026-11-20.
2. **The flow is the product; chat and other tools serve it.** Unverified: OS Flow a-269 (C47).
3. **Protect a ship date he set and keep a frozen scope frozen.** Unverified: OS Flow 2026-11-22.
4. **Count the cost in money and tokens, and cut a recurring cost that buys little.**
   - 2026-11-22, Forge 0.4.0: a republish read the whole page, "about 440k tokens per move", so moves now write only changed chunks.
   - 2026-11-22, shelf: skills kept unloaded "since an unused skill still costs tokens".
   - 2026-11-21, cache-tax: kept because an abandoned window "costs at most 7 pings, about 9% of one full re-read".
   - Unverified: OS Flow 2026-11-17, the two-hourly loop retired.
5. **Build only what was asked for; leave out the extra product that comes with it.**
   - 2026-11-12, caveman: only the core skill, because the CLI, proxy and cloud service "are a separate product nobody asked for".
   - 2026-11-22, oil-ui: two ideas taken, the whole skill rejected ("paid upsell, phones home, its own visual direction").
6. **Show, don't describe: anything visual gets a picture.** Unverified: OS Flow picture pages, 2026-11-23.
7. **What he reads must be quick to scan and quick to act on.**
   - 2026-11-20, Forge 0.3.0: "the long `why` paragraphs and the folded guide hard to follow", so asks became checklists with word limits.
   - 2026-11-20, Forge 0.3.1: he "could not find an ask because overdue-first and firing-date sorting made the numbers jump".
   - 2026-11-20, Forge 0.3.3: link pills "stood out more than the steps they belong to".
8. **Copy a tool he already likes before inventing one.** Unverified: Tab to accept as in Claude; n8n for the editor.
9. **Show a tool when the task needs it, not all the time.** Unverified: OS Flow a-272.
10. **One home for shared things, installable anywhere.**
    - 2026-11-12: "this repo is where every skill lives, so any new environment or AI tool installs them out of the box".
    - 2026-11-12: mods and the Forge moved here, rejecting staying in OS Flow "where no other project could install them".
    - 2026-11-01: this repo keeps its own memory, rejecting "the one repo whose memory lived somewhere else".
11. **Remove what nothing uses rather than keep a pointer to it.**
    - 2026-11-20: the old Forge master "is removed, not replaced with a pointer", since "nothing reading it".
12. **A judge works in its own context, so it does not anchor on what it checks.**
    - 2026-11-21, design-critic: rejected a second mode of the design-auditor "because a separate context judges without anchoring on the hand-off".
13. **Prefer the middle option that keeps the urgent visible over a pure rule.**
    - 2026-11-20, Forge 0.3.1: grouped by priority, rejecting "pure id order, which would bury a 'now' ask among 'later' ones".
14. **Set numbers from evidence, never from a guess.**
    - 2026-11-17, auto-handoff: rejected "an unsourced 200k" and the compaction count for 800k, measured against how often 160k fired.
