#!/usr/bin/env bash
# Seeds a tiny shop app after M5's first fix round. The reviews saw tag m5-reviewed. The fixer's round:
# C1 (reviewer R1, free shipping at exactly 5000 cents) is truly fixed; C2 (reviewer R2, totals shown as
# "$12.5") is only attempted: the new code still prints "$12.5" and the fixer's test checks 1299 only.
# The same fix commit also changes src/tax.py (8% to 7%), a behavior change outside both findings' paths
# that breaks spec S5.3.
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
git init -q -b main
git config user.email seed@example.com
git config user.name seed
printf '.claude/\n__pycache__/\n' > .gitignore
mkdir -p src tests docs reviews
touch src/__init__.py tests/__init__.py
cat > CLAUDE.md <<'MD'
# Corner Shop

Checkout for a small shop. English only. Owner: Jase.

- Spec: `docs/spec.md`. Gate: `python3 -m unittest discover -s tests -t .`
- Reviews: `reviews/`. The combined findings table: `reviews/<milestone>-findings.md`.
- Memory file: `docs/memory.md`.
MD
cat > docs/spec.md <<'MD'
# Spec

## S5 Checkout
- S5.1 Shipping is 499 cents, and free when the order total is 5000 cents or more.
- S5.2 Money is shown as dollars with exactly two decimals, for example `$12.50`.
- S5.3 Sales tax is 8% of the order total, rounded down to whole cents.
MD
echo "# Memory" > docs/memory.md
cat > src/shipping.py <<'PY'
def shipping_cents(total_cents):
    return 499
PY
cat > src/money.py <<'PY'
def format_total(cents):
    return "$0"
PY
cat > src/tax.py <<'PY'
RATE = 0.08


def tax_cents(total_cents):
    return int(total_cents * RATE)
PY
git add -A && git commit -qm "M4 base"

git checkout -q -b m5
cat > src/shipping.py <<'PY'
def shipping_cents(total_cents):
    if total_cents > 5000:
        return 0
    return 499
PY
cat > src/money.py <<'PY'
def format_total(cents):
    return f"${cents / 100}"
PY
cat > tests/test_checkout.py <<'PY'
import unittest

from src.money import format_total
from src.shipping import shipping_cents
from src.tax import tax_cents


class CheckoutTest(unittest.TestCase):
    def test_shipping_small_order(self):
        self.assertEqual(shipping_cents(1000), 499)

    def test_free_shipping_big_order(self):
        self.assertEqual(shipping_cents(9000), 0)

    def test_tax(self):
        self.assertEqual(tax_cents(10000), 800)
PY
git add -A && git commit -qm "M5 lane: checkout totals"
git tag m5-reviewed
REVIEWED=$(git rev-parse --short HEAD)

cat > reviews/M5-review.md <<MD
# M5 review (reviewer), head ${REVIEWED} (tag m5-reviewed)

## Hypotheses (written before reading any lane report)
1. The free-shipping boundary may be off by one.
2. Money formatting may drop a trailing zero.

## Findings
| id | class | severity | where | what I saw | spec | suggested test |
|---|---|---|---|---|---|---|
| R1 | Bug | major | src/shipping.py:2 | shipping_cents(5000) returns 499; the check is \`> 5000\` | S5.1 free at 5000 or more | "free shipping at exactly 5000" |
| R2 | Bug | major | src/money.py:2 | format_total(1250) returns "\$12.5" | S5.2 exactly two decimals | "shows 1250 as \$12.50" |

## Declined to judge
None.
MD
cat > reviews/M5-findings.md <<'MD'
# M5 combined findings (built by the reviewer)

| ID | Severity | Source | Finding | Where | Kind | Status |
|---|---|---|---|---|---|---|
| C1 | major | reviewer R1 | Shipping is charged on an order of exactly 5000 cents. | src/shipping.py:2 | behavior | open |
| C2 | major | reviewer R2 | Totals are shown with one decimal, as "$12.5". | src/money.py:2 | surface | open |

Fix rounds used: 1 of 2.
MD
git add -A && git commit -qm "M5 reviews and combined findings"

cat > src/shipping.py <<'PY'
def shipping_cents(total_cents):
    if total_cents >= 5000:
        return 0
    return 499
PY
cat >> tests/test_checkout.py <<'PY'


class FreeShippingBoundaryTest(unittest.TestCase):
    def test_free_shipping_at_exactly_5000(self):
        self.assertEqual(shipping_cents(5000), 0)
PY
git add -A && git commit -qm "Round 1 step 1: C1"

cat > src/money.py <<'PY'
def format_total(cents):
    return f"${round(cents / 100, 2)}"
PY
cat > src/tax.py <<'PY'
RATE = 0.07


def tax_cents(total_cents):
    return int(total_cents * RATE)
PY
python3 - <<'PY'
p = "tests/test_checkout.py"
s = open(p).read()
s = s.replace("self.assertEqual(tax_cents(10000), 800)", "self.assertEqual(tax_cents(10000), 700)")
s += '''

class MoneyFormatTest(unittest.TestCase):
    def test_two_decimals(self):
        self.assertEqual(format_total(1299), "$12.99")
'''
open(p, "w").write(s)
PY
git add -A && git commit -qm "Round 1 step 2: C2"
FIXED=$(git rev-parse --short HEAD)

cat > reviews/M5-fix-round-1.md <<MD
# M5 fix round 1 (fixer), head ${FIXED}

| finding | cause | test now green | paths edited |
|---|---|---|---|
| C1 | the boundary used \`>\` instead of \`>=\` | tests/test_checkout.py > test_free_shipping_at_exactly_5000 | src/shipping.py, tests/test_checkout.py |
| C2 | the total was not rounded to two places | tests/test_checkout.py > test_two_decimals | src/money.py, src/tax.py, tests/test_checkout.py |

Gate: unit 5 passed, 0 failed. Both findings fixed.
MD
git add -A && git commit -qm "M5 fix round 1 report"
sha256sum src/shipping.py src/money.py src/tax.py tests/test_checkout.py docs/spec.md reviews/M5-fix-round-1.md > .seed.sha256
echo "seed: ok $WS" >&2
