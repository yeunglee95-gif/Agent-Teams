# dimensional-drawing (shelved 2026-11-22)

**Source.** github.com/enesozturk/dimensional-drawing at `5c45743`, `skills/`, MIT (`LICENSE`). Copied whole and unchanged: `dimensional-drawing/` (the sheet) and `dimensional-drawing-motion/` (a 10-second video of the sheet).

**What it does.** One monochrome engineering sheet in the style of Apple's accessory dimensional drawings: every measurement is a named variable (S1 spacing, R2 radius) with a formula and a value table, an exploded view of the layers, and detail views. It never invents a value: anything not in the source is `[TBD]`. For a UI component it measures the real built component in Playwright. For a physical product it draws third-angle views and a section in mm, from published specs only. It is not a wireframe: it documents the exact dimensions of one thing that already exists, not a screen's layout.

**Why not now.** No current project needs spec sheets: the design hand-off cites design-system tokens by name, and the design system owns the values. The motion skill needs `npm install` and ffmpeg.

**Kept for.** Geniotek product spec sheets (product development and manufacturing), and a component reference sheet if a design system is ever handed to an outside team.
