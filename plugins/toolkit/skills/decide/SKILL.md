---
name: decide
description: >
  Weigh a choice the way Jase weighs it, then present it the way he reads it.
  Use for any choice put to Jase (an ask, a "which option", a "should we") and
  any choice made on his behalf. Checks the aspects he cares about, lists pros
  and cons, gives one recommendation with the reasoning as bullets, and logs
  where he overrides it. Plain markdown, so any model can follow it.
---

# decide

Jase often answers an ask with a bare "yes" or a letter, sometimes without reading the whole paragraph. **So the recommendation has to be the one he would pick if he had read everything**, and this skill exists to make that true. It is built from his own past decisions: `principles.md` holds what he values, ranked, and `calibration.md` holds every time he picked against the recommendation.

## When to use it

- Any choice you are about to put to Jase: an ask on the Forge, a question in chat, options in a plan.
- Any choice you make for him inside green-tier work (which library, which layout, how much to build). Make it with this method and say so in one line.
- Not for choices with one obvious answer. Pick it and move on.

## Before you weigh

1. Read `principles.md` once per session. Higher-ranked principles win a conflict.
2. Read `calibration.md` for overrides on the same kind of choice. **An override beats a principle** on the case it covers, because it is his newest word.
3. Read the project's own memory for decisions already made on this topic. Never re-ask a settled question; point to the entry instead.

## The aspects to check

Go through each one. Skip it only when it plainly does not apply, and do not write it up when it changes nothing.

- **Purpose.** What is the product or work for, and does this option serve that? The flow he is building is the product; a tool inside it is a means.
- **Frequency.** How often will he or his users do this? Polish what happens daily; keep rare paths plain.
- **Cost.** Money, tokens per run and per day, and seats or plans. Name the number when you can, for example "about 440k tokens per move".
- **Time to ship.** Does it move a date he set? A frozen scope or ship date wins unless he reopens it.
- **Tools he already uses.** Copy a pattern he already likes (a key, an editor, a layout) before inventing one.
- **Reversibility.** Can it be undone in a day? Two-way doors can move fast; one-way doors get the full write-up.
- **Risk to his work or data.** Could anything of his be lost, cleared, overwritten or sent without his say? That option needs his explicit go, whatever else is true.
- **Scope.** Is this something he asked for? Extra features, extra skills and extra products nobody asked for are a cost, not a gift.
- **Who else it touches.** Teammates, customers, other projects that copy this one.

## Weigh it

1. List two to four real options. Include "do nothing" or "a smaller version" when it is real. An option you would never recommend is padding; leave it out.
2. For each option, write its pros and cons from the aspects above, one line each.
3. **Pick one.** Never present options without a recommendation.
4. Check the pick against `principles.md` and `calibration.md`. If it goes against a principle, say which and why this case is different.
5. Write the reasoning as three to five bullets, each tied to an aspect.

## Present it

Jase reads asks fast, so the format does most of the work.

- **Show, don't describe.** Anything visual (a screen, a layout, a chart, a flow) gets a picture: a screenshot, a mock-up page or a diagram. Words about a picture are the fallback.
- **Three plain sentences** of context: what is being decided, why now, and what happens if nothing is chosen.
- **Options with letters**, the recommended one first and marked "(recommended)", each with its one-line trade-off.
- **The reasoning** as bullets under the recommendation.
- **One reply step**: what he types to choose, for example "a", "b" or a sentence.
- Plain words, no jargon he would have to look up, and no paragraph he must read to find the choice.

Example:

> **Where do new skills live?** Each app keeps its own copy today, so a new environment has to find them again. If we wait, the next project repeats the setup.
>
> - **a (recommended).** One shared plugin every app installs. One place to fix; apps pin a commit.
> - **b.** Each app keeps its own. No shared release step; every app drifts.
>
> Why a: one home is what he chose for teams; the cost is one install line; reversible by copying back.
>
> Reply "a" or "b".

## After he answers

1. Log the decision where the project logs decisions, the same turn: date, who, what was chosen, what was rejected, why.
2. **If he picked something other than the recommendation, or gave a reason that adds to or contradicts a principle, add an override** to the project's `decide-overrides.md` in the format in `calibration.md`. That file is how this skill learns; see `calibration.md` § How projects feed overrides in.
3. If he gave only "yes" or a letter, log the pick and do not invent a reason for it.

## Files

- `principles.md`: his principles, ranked, each with its evidence.
- `calibration.md`: the override log format, the overrides so far, and how projects feed new ones in.
- The replay test that checks this skill against his real picks is in `plugins/toolkit/evals/decide/`.

## Source

Written by this team, from Jase's ruling a-271 (a) on 2026-11-23 and his logged decisions in OS Flow and this repo.
