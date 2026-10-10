# Third-party sources

This team copies no outside skill. The one skill in `skills/` (`design-handoff`) is written by this team and says so in its `## Source` section. The design skills its roles use live on Jase's claude.ai account and are referenced by name, so there is no license text to ship in `licenses/`.

## Referenced, not copied

Each skill below is synced to Jase's account (in a session it is listed as `anthropic-skills:<name>`) and preloaded by plain name in the role's `skills:` list. The version, license and author columns say exactly what the synced files show, read on 2026-10-10; nothing is filled in from elsewhere.

| Skill | Where it lives | Version, license and author as found | Role | What for |
|---|---|---|---|---|
| impeccable | Jase's account skills (`anthropic-skills:impeccable`) | `version: '4.1.1'` in the frontmatter; no license or author field in `SKILL.md`; two detector scripts (`scripts/detector/detect-antipatterns.mjs` and `scripts/detector/detect-antipatterns-browser.js`) carry "Copyright (c) 2026 Paul Bakaus" and "SPDX-License-Identifier: Apache-2.0" headers | designer; design-auditor | designer: `shape` mode and craft guidance; design-auditor: `audit` mode only (craft, tokens, designed versus built) |
| ui-ux-pro-max | Jase's account skills (`anthropic-skills:ui-ux-pro-max`) | no license or version found in the synced files | designer; design-auditor | designer: palettes, font pairings, stack guidance; design-auditor: WCAG 2.2 accessibility checks only |
| design-system | Jase's account skills (`anthropic-skills:design-system`) | `license: MIT`; `metadata.author: claudekit`; `metadata.version: "1.0.0"` | designer | three-layer tokens (primitive, semantic, component), day and night, component state tables |
| emil-design-eng | Jase's account skills (`anthropic-skills:emil-design-eng`) | no license or version found in the synced files (one file, `SKILL.md`; its description names Emil Kowalski's design philosophy, not an author or license) | design-auditor | motion and interaction checks only |

Why they are referenced and not copied: impeccable is 153 files (3.6 MB) and runs its own node scripts; ui-ux-pro-max is 73 files (3.9 MB) with search data and scripts; emil-design-eng shows no license, so it cannot be copied. A role whose skill does not load works from its own text: the designer from the `design-handoff` skill and the app's design system, the design-auditor from the core checklist in its role file.

To check for a change: compare the skill's `SKILL.md` on Jase's account with the version recorded here. A change worth acting on lands here as a new plugin version with the new version recorded, never as a silent edit.
