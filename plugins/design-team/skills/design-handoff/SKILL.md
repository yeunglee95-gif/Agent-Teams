---
name: design-handoff
description: Use when writing a design hand-off for the dev team, or when checking a built screen against one. Says what a hand-off holds (screens, states, tokens used, motion, accessibility notes and acceptance notes per screen), where proposals to the design system go, and what a hand-off never does.
---

# Design hand-off

A design hand-off is what the dev team builds from and what the design-auditor checks against. One hand-off per milestone that changes screens. It lives in the folder or link the brief names (in OS Flow's terms, spec/09: a frozen snapshot a person reads as a picture and an AI reads as a Markdown brief). If the brief names no place, stop and ask.

The app's design system (the file its `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet) names; for OS Flow, Capsule in `docs/design/CAPSULE-DESIGN.md`) is the source of every token, rule and limit. The hand-off cites it by section and never restates it.

## What the folder holds

```
<hand-off folder>/
  README.md              the brief: milestone, screens in order, the design system file and commit read, open questions
  screens/<screen>.md    one file per screen, sections below
  screens/<screen>-*.png or .html   optional pictures or static mocks, one per state that needs one
  proposals.md           changes to the design system itself, for the owner (only when there are any)
```

## Each screen file

1. **Purpose.** One or two sentences: who uses this screen, for what.
2. **Layout.** Regions in reading order, with the spacing and type tokens each uses.
3. **States.** Every state the screen can be in, each named: default, loading, empty, error, disabled, and, for each control, hover, pressed and focus. Day and night where the app has both. A state the screen cannot reach says so ("no empty state: the list always has the seeded row").
4. **Tokens used.** Semantic token names only (`--color-text-muted`, not a hex). A value the design system does not have is not invented here: it goes to `proposals.md`.
5. **Motion.** What moves, from where to where, duration and easing, inside the app's motion limit, and what happens under reduced motion.
6. **Accessibility.** The text and background pairs with their contrast ratio, focus order, the focus ring used, accessible names for icon-only controls, target sizes.
7. **Copy.** Every visible string, in every language the app ships, or a pointer to the app's copy keys.
8. **Acceptance notes.** Numbered lines the design-auditor can check on the built screen, one fact each, with the state it applies to. For example: "A1 (empty): the list shows the line 'No reminders yet' and the button 'Add a reminder'."

## Proposals to the design system

A hand-off extends the design system; it never replaces it. A new token, a changed value, a new component or a rule change goes in `proposals.md`: what, why, which screen needs it, and what the screen does until the owner decides. The design system file changes only after the owner approves the proposal, and then through the owner's chosen hand, not the hand-off.

## Never

- Edit app code, tests or the design system file.
- Restate a rule the design system already holds; cite its section.
- Leave a state or acceptance note to the builder's guess. A gap found later goes back to the designer, never filled by the lane.

## Source

Written by this team, from OS Flow's spec/09 (Design Hand-off and Folder Mapping, repo yeunglee95-gif/os-flow) and the owner's design-team scope of 2026-10-10. No outside text was copied.
