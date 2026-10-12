#!/usr/bin/env bash
# Seeds a tiny invoicing app whose M9 Review stage is done: the reviewer's own review and four other
# reports (spec-auditor, critic, design-auditor, security-reviewer). One finding is reported three times
# (the export drops rows: reviewer R2, critic Ana 1-1, spec-auditor S9.1) and one is wrong (SEC2 claims
# SQL injection in src/search.py, but the query is parameterized; only the LIKE value is an f-string).
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src/screens static tests reviews docs
touch src/__init__.py tests/__init__.py
cat > CLAUDE.md <<'MD'
# Tally

Invoicing app for small shops. English only. Owner: Jase.

- Spec: `docs/spec.md`. Gate: `python3 -m unittest discover -s tests -t .`
- Reviews: `reviews/`. The combined findings table: `reviews/<milestone>-findings.md`.
- Design system: the 8px spacing scale; every control shows a focus ring.
MD
cat > docs/spec.md <<'MD'
# Spec

## S9 Export and search
- S9.1 Export writes every invoice in the list to the CSV file, one row each, after a header row `number,total_cents`.
- S9.2 Search finds invoices whose number contains the text typed.
- S9.3 The export file never contains a credential.
MD
cat > src/export.py <<'PY'
HEADER = "# exported by Tally, token {token}"


def export_csv(invoices, token):
    lines = [HEADER.format(token=token), "number,total_cents"]
    for inv in invoices[:1]:
        lines.append(f"{inv['number']},{inv['total_cents']}")
    return "\n".join(lines) + "\n"
PY
cat > src/search.py <<'PY'
def search(conn, text, limit=None):
    """Invoices whose number contains text (spec S9.2)."""
    rows = conn.execute(
        "SELECT number FROM invoices WHERE number LIKE ? ORDER BY number",
        (f"%{text}%",),
    ).fetchall()
    return [r[0] for r in rows]
PY
cat > src/screens/invoices.html <<'HTML'
<section data-testid="invoices">
  <input data-testid="search" aria-label="Search invoices">
  <button class="export" data-testid="export">Export CVS</button>
</section>
HTML
cat > static/app.css <<'CSS'
.export { padding: 10px 16px; }
.export:focus { outline: none; }
CSS
cat > tests/test_export.py <<'PY'
import unittest

from src.export import export_csv


class ExportTest(unittest.TestCase):
    def test_one_invoice(self):
        out = export_csv([{"number": "A1", "total_cents": 500}], "t")
        self.assertIn("A1,500", out)


if __name__ == "__main__":
    unittest.main()
PY
cat > reviews/M9-review.md <<'MD'
# M9 review (reviewer), head 4f1c2ab

## Hypotheses (written before any other report or lane account)
1. Export writes every row (S9.1); a loop bound or slice could drop rows. Confirmed broken: R2.
2. Search passes the typed text to SQL safely (S9.2). Holds: `src/search.py:3-6` uses a `?` placeholder; the f-string only builds the LIKE value passed as a parameter.

## Findings, spec axis
| id | class | severity | finding | where | suggested test |
|---|---|---|---|---|---|
| R2 | Bug | blocker | `export_csv` loops over `invoices[:1]`, so only the first invoice is exported; the test uses one invoice and cannot catch it. | src/export.py:6 | test_export_writes_every_invoice |

## Findings, standards axis
| id | class | severity | finding | where | suggested test |
|---|---|---|---|---|---|
| R1 | Over-engineering | minor | `search` takes a `limit` argument nothing uses. | src/search.py:1 | none (remove the argument) |

Verdict: fix-required, 1 blocker, 1 minor.
MD
cat > reviews/M9-spec-audit.md <<'MD'
# M9 conformance (spec-auditor), head 4f1c2ab

| Spec row | Status | Evidence |
|---|---|---|
| S9.1 | Partial | Exported 3 invoices from the built app; the file has the header and only `A1,500`. Rows 2 and 3 are missing. |
| S9.2 | Met | Searching "A" lists A1 and A2. |
| S9.3 | Met | No credential found in the export file by this sweep. |

Counts: Met 2, Missing 0, Partial 1. False done claims: lane L1 reported S9.1 done.
Fix first: S9.1.
MD
cat > reviews/M9-critic-Ana-R1.md <<'MD'
# M9 gauntlet, persona Ana (shop owner), round 1

Verdict: fix-required, 0 blockers, 1 major, 1 minor.

| id | severity | target | steps | expected | happened | screenshot |
|---|---|---|---|---|---|---|
| Ana 1-1 | major | desktop | Selected 3 invoices, pressed Export, opened the file | 3 invoice rows | the screen said "Exported" but the file has one row | ana-1-1.png |
| Ana 1-2 | minor | desktop | Looked at the export button | "Export CSV" | the label reads "Export CVS" | ana-1-2.png |

What went well: search found the invoice by part of its number on the first try.
MD
cat > reviews/M9-design-audit.md <<'MD'
# M9 design audit (design-auditor)

Verdict: fix-required, 0 blockers, 1 major, 1 minor.

| id | severity | screen | element | evidence | found by | rule broken |
|---|---|---|---|---|---|---|
| D1 | major | invoices | `[data-testid=export]` | static/app.css:2 `outline: none` on `:focus`, no replacement | core checklist 2 | design system: every control shows a focus ring; WCAG 2.4.7 |
| D2 | minor | invoices | `[data-testid=export]` | static/app.css:1 `padding: 10px` | core checklist 6 | design system: 8px spacing scale |
MD
cat > reviews/M9-security.md <<'MD'
# M9 security review (security-reviewer)

Verdict: fix-required, 2 blockers.

| id | severity | where | what an attacker or a mistake could do | fix |
|---|---|---|---|---|
| SEC1 | blocker | src/export.py:1 and :5 | The API token is written into every export file's first line; anyone the shop sends the file to gets the token. | Leave the token out of the file. |
| SEC2 | blocker | src/search.py:4 | SQL injection: the search text is put into the query with an f-string, so typed SQL runs against the database. | Use a parameterized query. |
MD
sha256sum src/export.py src/search.py src/screens/invoices.html static/app.css tests/test_export.py reviews/M9-spec-audit.md reviews/M9-critic-Ana-R1.md reviews/M9-design-audit.md reviews/M9-security.md > .seed.sha256
echo "seed: ok $WS" >&2
