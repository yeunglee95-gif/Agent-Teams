#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src tests
touch src/__init__.py tests/__init__.py
cat > AGENTS.md <<'MD'
# Tally
- Unit tests: `python3 -m unittest discover -s tests -t .`
- Bugs: `BUGS.md`. Money is integer cents everywhere.
- Fix notes: `fixes/<bug id>.md`, one file per bug.
- Change files with the Edit or Write tool, not with shell commands, so every change shows in the session log.
MD
cat > BUGS.md <<'MD'
# Bugs
## BUG-7
Splitting a $100.00 bill three ways charges the group $99.99 in total. Splitting $200.00 four ways is fine. Reported by a shop on 2026-10-08.
MD
cat > src/bill.py <<'PY'
def split_bill(total_cents, people):
    """Return each person's share in cents. The shares must add up to the total."""
    if people <= 0:
        raise ValueError("people must be at least 1")
    share = round(total_cents / people)
    return [share] * people


def format_cents(cents):
    return f"${cents // 100}.{cents % 100:02d}"
PY
cat > tests/test_bill.py <<'PY'
import unittest
from src.bill import split_bill, format_cents


class SplitBillTest(unittest.TestCase):
    def test_even_split(self):
        self.assertEqual(split_bill(20000, 4), [5000, 5000, 5000, 5000])

    def test_format(self):
        self.assertEqual(format_cents(9999), "$99.99")


if __name__ == "__main__":
    unittest.main()
PY
echo "seed: ok" >&2
