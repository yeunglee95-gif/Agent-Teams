---
name: design-critique
description: How the design-critic judges an app's design itself (each page's main job, information architecture, hierarchy, competing controls, consistency, usability) from screenshots, before reading any hand-off, and the report it files. Use in the dev team's Review stage on a milestone that changes screens.
---

# Design critique

The design-auditor checks the build against its hand-off, so a weak hand-off passes; the critic finishes tasks without judging the design. This critique asks the question neither does: **is this a good design for the person using it?** OS Flow's 2026-11-21 user round is the kind of finding it exists for: panels hiding each other, three buttons for one action, two home pages that look alike, empty pages (Jase, 2026-11-21).

## Input

- The milestone's screenshots at the app's two targets (for example 1440x900 and 390x844), in both themes, in every language the app ships. Take them from the milestone's user round, or capture them fresh from the reviewed head.
- The plan's Review Focus list.
- **Never the hand-off, the spec or the design system before the first impressions are written.** The critique judges what a person sees, not what was meant.

## Method

Per screen, then across screens:

1. **Main job.** What is this page for, in one line? Does the layout put that first?
2. **Information architecture.** Where things live, how a person finds them, whether names tell similar places apart.
3. **Hierarchy and density.** What draws the eye first. Empty space that carries nothing. Crowding.
4. **Duplicate or competing controls.** More than one door to the same thing. Controls far from what they act on.
5. **Consistency.** Similar pages that behave differently. Desktop and phone that disagree.
6. **Usability heuristics.** Visibility of state, the user's own words, control and freedom, error prevention, recognition over recall.

Write **First impressions** first: three to five lines per screen, before any finding.

**Then walk the running app blind** (Jase, 2026-11-22), still before the hand-off. Serve the reviewed head as the app's `AGENTS.md` says and drive it in a browser (the toolkit's `agent-browser`, or Playwright), never reading its code. In your own words, write what the product is and who it is for, then pick the one path you think matters most and follow it from a real entry point to a result. Log each step as **saw**, **why I did it**, **what happened**, and mark a step **stuck** (cannot go on), **wrong turn** (the result was not what you expected, so you went back) or **hesitated** (had to guess or compare). Note whether you could tell the app was working, done or failed, and whether that feedback appeared near the action. Report at most three walk findings, each as a `K<N>` with **observed** (where, what you did, what happened, the screenshot), **likely cause** and **result to aim for**. When the app cannot be served or operated, write `Walk: static only` and why; never claim a walk you did not make.

Only then may the hand-off be read, to mark findings the hand-off itself asked for (they stay findings: a weak hand-off is the reason this check exists).

## Each finding

- **Id**: `K<N>`, never reused.
- **Severity**: blocker (a person cannot tell how to do the page's main job), major (the design works against the person: a competing control, a misleading name, a hidden state), minor (polish with no effect on getting the job done).
- **Screen, target, theme and language** it was seen on, and the screenshot file.
- **What is wrong**, **why it matters to a person**, and **a direction for the fix** (a direction, not a redesign).
- **Seen in screenshot**: `yes` or `not confirmed`, filled by the Claude reader (below).

## Report

`reviews/CRITIQUE-<milestone>-<date>.md`, unless the app's `AGENTS.md` names another place.

1. First line: the verdict, `CLEAN` or `fix-required` with counts by severity.
2. Second line: `Model: <model> via <route>`, for example `Model: gpt-6.2-astra via codex exec (ChatGPT plan)` or `Model: Claude <model> (fallback: <reason>)`.
3. Third line: `Walk: <the path walked and how far it got>`, or `Walk: static only (<why>)`.
4. First impressions, per screen, then the walk log.
5. Findings, highest severity first.
6. Last line, the dev team's Coverage line: `Coverage: head <sha>; checked: <screens, targets, themes, languages>; not checked: <what, and why, or none>`.

## The Claude reader

A finding from another model joins the combined findings table only after a Claude reader has looked: the design-critic checks each `K<N>` against its screenshot and fills **Seen in screenshot**. A `not confirmed` finding stays in the report; the reviewer lists it as `disputed` in the combined table until its source confirms or withdraws it. Nothing is deleted.

## Source

The blind walk is an idea from `references/ux-reviewer.md` in oil-oil/oil-ui at `eebeee4` (MIT, Copyright (c) 2026 oil-oil), rewritten; no text copied. The rest is adapted from OS Flow's `routine/BRIEF-design-critique.md` and stage 7 of its `routine/milestone-loop.md` (yeunglee95-gif/os-flow, branch `m4b/integrate-w3` at `8dddce85`), Jase's own method, so this file is now its one home.
