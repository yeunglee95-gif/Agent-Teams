---
name: grill-the-plan
description: Use before writing a milestone plan, a spec change or a contract change, whenever the owner's request leaves decisions open. Interviews the owner in short rounds until no decision is left open; looks up every fact itself; writes nothing into a plan until the owner confirms. Keeps the app's glossary current as terms settle.
---

# Grill the plan

A plan built on a guessed decision is rebuilt later at a higher price. Before you write a plan, find every open decision and put it to the owner, with your recommendation, until none is left.

## Facts are yours, decisions are the owner's

- **A fact** is anything the code, the specs, the memory file, the app's `CLAUDE.md` or an outside service can answer: what the code does now, which files a change touches, what a library supports. Look it up yourself, or send a sub-agent to look it up. Never ask the owner for something you could read.
- **A decision** is a choice between real options: what the feature should do, what to drop, what a term means, what to trade for speed or cost. Only the owner makes it. Put it to them and wait.
- When the owner's answer contradicts the code ("you said partial cancellation is possible, but the code cancels whole orders"), say so at once and ask which is right.

## Rounds

Map the decisions as a tree: each one branches into the decisions that depend on it. The open frontier is every decision whose prerequisites are settled. Each round:

- Ask at most four questions, from the frontier only. A question that depends on another question still open in this round waits for the next round.
- Number each question. Give the options in plain words, then your recommended answer and one line on why. Word it so "yes" accepts your recommendation.
- Write so the owner, who is not a software engineer, can answer without asking what a term means.
- While a sub-agent is still looking up a fact, ask only the questions that do not depend on it.

```
Q1. <title>: <the question, with the options>
Recommended: <your answer>, because <one line>.
```

After each round, record the answers in the memory file as decisions (date, what was chosen, what was rejected, why), recompute the frontier and ask the next round.

## Terms

When a term is vague or used two ways ("account": the customer or the login?), propose one precise word and ask. When a term settles, write it at once into the one glossary file the app's `CLAUDE.md` names: the term, a one- or two-sentence definition of what it is, and the words to avoid. Only terms specific to this app; no implementation details. If the `CLAUDE.md` names no glossary file, ask the owner where it goes; never start a second one.

## Decision records

Offer a decision record only when all three are true:

1. Hard to reverse: changing your mind later costs a day or more.
2. Surprising without context: a future reader would ask "why did they do it this way?"
3. A real trade-off: there were real options and one was picked for a reason.

If any is missing, a one-line decision in the memory file is enough. When all three hold, write it with the `decision-record` skill; it stays Proposed until the owner says yes.

## Done

Done when the frontier is empty: every branch visited, nothing silently assumed. Then list the decisions made, in one block, and ask the owner to confirm there is no open decision left. Write nothing into a plan, spec or contract until the owner confirms.

## Source

Adapted from `skills/productivity/grilling/SKILL.md` and `skills/engineering/domain-modeling/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. Changed: merged into one skill and rewritten in this team's voice; the user is the owner; at most four questions a round; answers logged in the memory file; the glossary goes to the one file the app's `CLAUDE.md` names instead of a `GLOSSARY.md` the skill creates; domain-modeling's ADR format not taken, only its three-part test, with records written through the `decision-record` skill; nothing written into a plan until the owner confirms. License text: `../../licenses/mattpocock-skills-MIT.txt`.
