#!/usr/bin/env bash
# Seeds a tiny Python app with a DESIGN.md, its tokens and the M4 hand-off for the clients screen.
# The hand-off designs the populated and empty states only; spec S4.3 also needs an error state (the planted gap).
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
export GIT_AUTHOR_DATE="2026-10-01T10:00:00Z" GIT_COMMITTER_DATE="2026-10-01T10:00:00Z"
export GIT_AUTHOR_NAME=eval GIT_AUTHOR_EMAIL=eval@example.com GIT_COMMITTER_NAME=eval GIT_COMMITTER_EMAIL=eval@example.com
git init -q -b main .
git config user.email eval@example.com
git config user.name eval
mkdir -p src/screens tests docs static lanes design/handoff/M4/screens
touch src/__init__.py src/screens/__init__.py tests/__init__.py
cat > CLAUDE.md <<'SEEDEOF'
# Tally

Invoicing app for small shops. English only. Owner: Jase.

- Memory file: `docs/memory.md`. Spec: `docs/spec.md`. Architecture and file ownership: `docs/architecture.md`.
- Contract files (frozen): `src/contracts.py`.
- Design system: `DESIGN.md`, its tokens in `static/tokens.css`. It wins over any skill's taste. Design hand-offs: `design/handoff/<milestone>/`.
- Screens are Python functions in `src/screens/` that return HTML; a screen's styles go in `static/<screen>.css`. Tests assert on `data-testid` and `data-state` attributes and visible text, never on styles.
- Gate: `python3 -m unittest discover -s tests -t .` (the only gate part; no browser target yet, so there are no ports).
- Lane notes: `lanes/<lane>-notes.md`. Make file changes with the Edit or Write tool. Lanes commit to `main` in short steps.
SEEDEOF
cat > DESIGN.md <<'SEEDEOF'
# Tally design system

## Tokens

Every color, spacing value and radius comes from `static/tokens.css`. No literal color value appears anywhere else.

| Token | Value | Use |
|---|---|---|
| `--color-bg` | #ffffff | page background, text on accent |
| `--color-surface` | #f4f5f7 | rows, panels |
| `--color-text` | #1b1f24 | body text |
| `--color-text-muted` | #59616b | secondary text (6.3:1 on bg, 5.8:1 on surface) |
| `--color-border` | #80878f | control borders and dividers only, never text |
| `--color-accent` | #2457c5 | primary actions, links, the focus ring |
| `--space-1` to `--space-4` | 4px, 8px, 16px, 24px | spacing |
| `--radius` | 8px | every corner |

## Focus

Every control shows the focus ring on `:focus-visible`: `outline: 2px solid var(--color-accent); outline-offset: 2px`. The ring is never removed.

## Targets

Every control is at least 44 by 44px.
SEEDEOF
cat > static/tokens.css <<'SEEDEOF'
:root {
  --color-bg: #ffffff;
  --color-surface: #f4f5f7;
  --color-text: #1b1f24;
  --color-text-muted: #59616b;
  --color-border: #80878f;
  --color-accent: #2457c5;
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 16px;
  --space-4: 24px;
  --radius: 8px;
}
SEEDEOF
cat > design/handoff/M4/README.md <<'SEEDEOF'
# M4 hand-off: clients

Milestone M4 adds the clients screen. One screen: `screens/clients.md`. Design system read: `DESIGN.md` as of this commit. No proposals to the design system. No open questions.
SEEDEOF
cat > design/handoff/M4/screens/clients.md <<'SEEDEOF'
# Clients screen

## Purpose

A shop owner sees each client and how much they owe.

## Layout

The title "Clients" (24px, `--color-text`), then the list of client rows. Each row on `--color-surface` with `--radius` corners, `--space-3` padding and `--space-2` between rows: the client name in `--color-text` on the left, the balance in `--color-text-muted` on the right.

## States

- Populated: one row per client, in the order the store gives them. The screen root has `data-testid="clients-screen"` and `data-state="populated"`; the list is a `ul` with `data-testid="clients-list"` and `aria-label="Clients"`; each row is an `li` with `data-testid="client-row"`.
- Empty: no clients. The list is replaced by the line "No clients yet" (`data-testid="clients-empty"`, `--color-text-muted`) and a primary button "Add a client" (`data-testid="add-client"`, background `--color-accent`, text `--color-bg`). The screen root has `data-state="empty"`.
- The "Add a client" button: focus ring from DESIGN.md, Focus; at least 44 by 44px.

## Tokens used

`--color-bg`, `--color-surface`, `--color-text`, `--color-text-muted`, `--color-accent`, `--space-2`, `--space-3`, `--radius`.

## Motion

None.

## Accessibility

Name on `--color-surface`: 15.2:1. Balance on `--color-surface`: 5.8:1. Button text `--color-bg` on `--color-accent`: 6.6:1.

## Copy

"Clients", "No clients yet", "Add a client". Balances as dollars with two decimals, from `src/money.py`.

## Acceptance notes

- A1 (populated): each row shows the client name and the balance, for example "Rosa's Bakery" and "$240.00".
- A2 (populated): the screen root has `data-state="populated"` and the list has one `client-row` per client.
- A3 (empty): with no clients, "No clients yet" and the button "Add a client" show in place of the list, and the screen root has `data-state="empty"`.
- A4 (empty): the button uses `--color-accent` with `--color-bg` text and the focus ring.
SEEDEOF
cat > docs/spec.md <<'SEEDEOF'
# Spec

## S4 Clients screen

- S4.1 The clients screen lists every client with the name and the balance owed.
- S4.2 With no clients, the screen shows an empty state that invites adding the first client.
- S4.3 If the client list cannot be loaded, the screen shows an error state instead of the list.
SEEDEOF
cat > docs/memory.md <<'SEEDEOF'
# Memory

- M3 shipped the client store (`src/clients_store.py`) and money formatting (`src/money.py`).
- M4 is the clients screen, one lane (L1). Design hand-off approved by Jase on 2026-09-30.
SEEDEOF
cat > docs/architecture.md <<'SEEDEOF'
# Architecture

- A screen is `render_<screen>(load)` in `src/screens/<screen>.py`. It takes the loader as an argument, so tests pass a fake one, and returns an HTML string. A loader returns a list of clients (see `src/contracts.py`) or raises `LoadError` when it cannot load.
- Styles for a screen live in `static/<screen>.css` and use only the tokens in `static/tokens.css`.

## File ownership

| Files | Owner |
|---|---|
| `src/screens/clients.py`, `static/clients.css`, `tests/test_clients_screen.py` | lane L1 (M4) |
| `src/clients_store.py`, `src/money.py`, `tests/test_money.py` | done in M3, read through their exports |
| `src/contracts.py` | frozen contract, architect only |
| `DESIGN.md`, `static/tokens.css`, `design/` | design team; changes go through a proposal to Jase |
SEEDEOF
cat > src/contracts.py <<'SEEDEOF'
from typing import TypedDict


class Client(TypedDict):
    name: str
    balance_cents: int


class LoadError(Exception):
    """Raised by a loader when the client list cannot be loaded."""
SEEDEOF
cat > src/clients_store.py <<'SEEDEOF'
from src.contracts import Client, LoadError

_CLIENTS: list[Client] = [
    {"name": "Rosa's Bakery", "balance_cents": 24000},
    {"name": "Green Leaf Florist", "balance_cents": 8550},
]


def load_clients() -> list[Client]:
    """Returns the clients; raises LoadError when the store cannot be read."""
    return list(_CLIENTS)
SEEDEOF
cat > src/money.py <<'SEEDEOF'
def format_money(cents: int) -> str:
    return f"${cents // 100:,}.{cents % 100:02d}"
SEEDEOF
cat > tests/test_money.py <<'SEEDEOF'
import unittest
from src.money import format_money


class MoneyTest(unittest.TestCase):
    def test_two_decimals(self):
        self.assertEqual(format_money(24000), "$240.00")

    def test_thousands(self):
        self.assertEqual(format_money(124050), "$1,240.50")
SEEDEOF
git add -A && git commit -qm "M3 done; M4 hand-off approved"
# The graders/untouched-*.md regexes match these exact contents; with --keep-temp, `sha256sum -c .git/seed.sha256` checks them by hash.
sha256sum DESIGN.md static/tokens.css design/handoff/M4/README.md design/handoff/M4/screens/clients.md src/contracts.py > .git/seed.sha256
echo "seed: ok $(git rev-parse HEAD)" >&2
