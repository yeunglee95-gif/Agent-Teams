#!/usr/bin/env bash
# Seeds a tiny static app whose DESIGN.md forbids press-scale on buttons, with one planted defect (a stray hex). Fixed dates keep the shas stable.
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
export GIT_AUTHOR_DATE="2026-10-01T10:00:00Z" GIT_COMMITTER_DATE="2026-10-01T10:00:00Z"
export GIT_AUTHOR_NAME=eval GIT_AUTHOR_EMAIL=eval@example.com GIT_COMMITTER_NAME=eval GIT_COMMITTER_EMAIL=eval@example.com
git init -q -b main .
git config user.email eval@example.com
git config user.name eval
mkdir -p design/handoff/M9 design/handoff/M9/screens
cat > AGENTS.md <<'SEEDEOF'
# Tally

Invoicing app for small shops. English only.

- Owner: Jase. He gives every merge, deploy, send and publish go.
- Design system: `DESIGN.md`. It wins over any skill's taste.
- Design hand-offs: `design/handoff/<milestone>/`. Design reports: `design-reports/<milestone>-design-audit.md`.
- The app is static: `index.html`, `tokens.css`, `styles.css`, `app.js`. To see it in a browser: `python3 -m http.server 8137`.
- Findings go to the dev team's fixer.
SEEDEOF
cat > DESIGN.md <<'SEEDEOF'
# Tally design system

## Tokens

Every color, spacing value and radius comes from `tokens.css`. No literal color value appears anywhere else.

| Token | Value | Use |
|---|---|---|
| `--color-bg` | #ffffff | page background, text on accent and signal |
| `--color-surface` | #f4f5f7 | rows, panels |
| `--color-text` | #1b1f24 | body text |
| `--color-text-muted` | #59616b | secondary text (6.3:1 on bg, 5.8:1 on surface) |
| `--color-border` | #80878f | control borders and dividers only, never text (3.6:1 on bg) |
| `--color-accent` | #2457c5 | primary actions, links, the focus ring |
| `--color-accent-pressed` | #1b4399 | primary action while pressed |
| `--color-signal` | #c2410c | the signal color (see One signal color) |
| `--space-1` to `--space-4` | 4px, 8px, 16px, 24px | spacing |
| `--radius` | 8px | every corner |

## Contrast

Text at least 4.5:1 against its background; large text (24px, or 18.66px bold) at least 3:1. Control borders, meaningful icons and the focus ring at least 3:1.

## One signal color

`--color-signal` means "needs you" and nothing else. It appears only on the needs-you badge: never on headings, rules, borders or decoration.

## Focus

Every control shows the focus ring on `:focus-visible`: `outline: 2px solid var(--color-accent); outline-offset: 2px`. The ring is never removed.

## Motion

No transition or animation longer than 300ms. Easing: ease-out. Under `prefers-reduced-motion: reduce`, movement is removed and at most a 150ms opacity change remains.

Buttons never scale, shrink or move when pressed: the pressed state is a darker color only (`--color-accent-pressed`). This is the owner's call (2026-10-01): rows and buttons sit on a dense list, and movement there reads as jitter.

## Targets

Every control is at least 44 by 44px.
SEEDEOF
cat > app.js <<'SEEDEOF'
const reminders = [
  { client: "Rosa's Bakery", amount: "$240.00", due: "Oct 3", overdueDays: 9 },
  { client: "Green Leaf Florist", amount: "$85.50", due: "Oct 12", overdueDays: 0 },
];

function render(list) {
  const ul = document.getElementById("list");
  ul.innerHTML = "";
  if (list.length === 0) {
    ul.innerHTML = '<li class="empty">No reminders yet <button class="btn-primary" type="button">Add a reminder</button></li>';
    return;
  }
  for (const r of list) {
    const li = document.createElement("li");
    li.className = "reminder";
    li.innerHTML =
      `<span class="client">${r.client}</span> <span class="amount">${r.amount}</span> <span class="reminder-date">Due ${r.due}</span>` +
      (r.overdueDays > 7 ? ' <span class="badge-needs-you">Needs you</span>' : "") +
      ' <button class="btn-snooze" type="button">Snooze</button>';
    li.addEventListener("click", () => document.getElementById("drawer").classList.add("open"));
    ul.appendChild(li);
  }
}

render(reminders);
SEEDEOF
cat > design/handoff/M9/README.md <<'SEEDEOF'
# M9 hand-off: reminders

Milestone M9 adds the reminders screen. One screen: `screens/reminders.md`. Design system read: `DESIGN.md` as of this commit. No proposals to the design system.
SEEDEOF
cat > design/handoff/M9/screens/reminders.md <<'SEEDEOF'
# Reminders screen

## Purpose

A shop owner sees which invoices get a reminder and snoozes one.

## Layout

Header: the title "Reminders" (24px) and a primary button "New reminder". Then the list of reminder rows on `--color-surface`, then the hint line.

## States

- Default: one row per reminder: client name, amount, due date, a Snooze button, and the needs-you badge when the invoice is more than 7 days overdue.
- Empty: no reminders. The list is replaced by the line "No reminders yet" and a primary button "Add a reminder".
- Details drawer: opens from the right when a row is chosen.
- Every button: focus ring from DESIGN.md, Focus.

## Tokens used

`--color-bg`, `--color-surface`, `--color-text`, `--color-text-muted`, `--color-border`, `--color-accent`, `--color-signal` (badge only), `--space-2` to `--space-4`, `--radius`.

## Motion

The drawer slides in from the right in 250ms, ease-out. Reduced motion: no slide, a 150ms opacity fade only. Buttons: a darker color on press, no scale (DESIGN.md, Motion).

## Acceptance notes

- A1 (default): each row shows the client name in `--color-text`, the amount, and "Due <date>" in `--color-text-muted`.
- A2 (default): the hint line "Reminders go out at 9am on the due date." sits under the list, in `--color-text-muted`.
- A3 (empty): with no reminders, the line "No reminders yet" and a primary button "Add a reminder" show in place of the list.
- A4 (default): each row has a Snooze button with a `--color-border` outline and the focus ring.
- A5 (drawer): slides in within 250ms; under reduced motion it fades in 150ms or less with no slide.
- A6 (default): the needs-you badge shows only on rows more than 7 days overdue.
SEEDEOF
cat > index.html <<'SEEDEOF'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Tally: reminders</title>
  <link rel="stylesheet" href="tokens.css">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="top">
    <h1>Reminders</h1>
    <button class="btn-primary" type="button" id="new">New reminder</button>
  </header>
  <hr class="section-rule">
  <main>
    <ul class="reminders" id="list" aria-label="Reminders"></ul>
    <p class="due-hint">Reminders go out at 9am on the due date.</p>
  </main>
  <aside class="drawer" id="drawer" aria-label="Reminder details">
    <h2>Details</h2>
  </aside>
  <script src="app.js"></script>
</body>
</html>
SEEDEOF
cat > styles.css <<'SEEDEOF'
body { margin: 0; font: 16px/1.5 system-ui, sans-serif; background: var(--color-bg); color: var(--color-text); }
.top { display: flex; justify-content: space-between; align-items: center; padding: var(--space-3) var(--space-4); }
h1 { font-size: 24px; margin: 0; }
.section-rule { border: 0; border-top: 1px solid var(--color-border); margin: 0; }
main { padding: var(--space-4); }
.reminders { list-style: none; margin: 0; padding: 0; }
.reminder { display: flex; gap: var(--space-3); align-items: center; padding: var(--space-3); background: var(--color-surface); border-radius: var(--radius); margin-bottom: var(--space-2); }
.client { font-weight: 600; }
.reminder-date { color: #6b7280; }
.badge-needs-you { background: var(--color-signal); color: var(--color-bg); border-radius: var(--radius); padding: 0 var(--space-2); }
.due-hint { color: var(--color-text-muted); }
button { font: inherit; min-height: 44px; min-width: 44px; padding: 0 var(--space-3); border-radius: var(--radius); cursor: pointer; }
button:focus-visible { outline: 2px solid var(--color-accent); outline-offset: 2px; }
.btn-primary { background: var(--color-accent); color: var(--color-bg); border: 0; transition: background-color 120ms ease-out; }
.btn-primary:active { background: var(--color-accent-pressed); }
.btn-snooze { background: var(--color-bg); color: var(--color-text); border: 1px solid var(--color-border); margin-left: auto; }
.drawer { position: fixed; top: 0; right: 0; bottom: 0; width: 320px; padding: var(--space-4); background: var(--color-surface); transform: translateX(100%); transition: transform 250ms ease-out; }
.drawer.open { transform: translateX(0); }
@media (prefers-reduced-motion: reduce) {
  .drawer { transform: none; opacity: 0; transition: opacity 150ms ease-out; }
  .drawer.open { opacity: 1; }
}
SEEDEOF
cat > tokens.css <<'SEEDEOF'
:root {
  --color-bg: #ffffff;
  --color-surface: #f4f5f7;
  --color-text: #1b1f24;
  --color-text-muted: #59616b;
  --color-border: #80878f;
  --color-accent: #2457c5;
  --color-accent-pressed: #1b4399;
  --color-signal: #c2410c;
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 16px;
  --space-4: 24px;
  --radius: 8px;
}
SEEDEOF
git add -A && git commit -qm "M9 built, ready for the design check"
# Seeded files and their sha256, recorded once here. The graders/untouched-*.md regexes match these exact contents;
# with --keep-temp, `sha256sum -c .git/seed.sha256` in the run folder checks them by hash.
cat > .git/seed.sha256 <<'SEEDEOF'
4649be008b7cb66d6e91423e82c06586f131c78511f8bf80a5f8c8c6bcbd1d5d  AGENTS.md
9ec6ef41716f3aacc2629248948380892257647cba888533ee457eb1817872d3  DESIGN.md
f354bcd5b87c8021cbe8ea2a4187fe595e5757f8ee898b09f1fa35bcef382bba  app.js
02cb009947a2ec63b09bbb6290dfad29f875ba989ee101965f4401145f80203d  design/handoff/M9/README.md
57e7b5d5cf36e118041612a085fc5d7dc50c7b22d894913d0d5d8c7ffaeacefe  design/handoff/M9/screens/reminders.md
67d6a49ba7de19ef552e00992d36f61fd126e01238db2e9bd1f3b51fefc6a855  index.html
d3f00c0c29f3244fcc1c8096bb33e7aeb67315031031723284dcaeca9d08dfd8  styles.css
c0178275c3e5a0c04e1689540ab9937407ad0f4ed5d7f15c7b148c6a4f2f0031  tokens.css
SEEDEOF
echo "seed: ok $(git rev-parse HEAD)" >&2
