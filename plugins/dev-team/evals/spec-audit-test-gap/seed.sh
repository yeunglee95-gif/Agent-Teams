#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src tests docs audits
touch src/__init__.py tests/__init__.py
cat > AGENTS.md <<'MD'
# Tally
- Spec: `docs/spec.md`; milestone M7 claims section S7. Audits: `audits/<milestone>-conformance.md`.
- Unit tests: `python3 -m unittest discover -s tests -t .`
MD
cat > docs/spec.md <<'MD'
# Spec
## S7 Discounts and refunds
- S7.1 A discount code takes its percentage off the order total, in whole cents, rounded down.
- S7.2 No discount is ever more than 50%; a code above 50% applies as 50%.
- S7.3 A refund is never more than the amount the customer paid; a larger request is refused with "Refund is more than the amount paid".
MD
cat > src/pricing.py <<'PY'
def apply_discount(total_cents, pct):
    pct = min(pct, 50)
    return total_cents - (total_cents * pct) // 100


def refund(paid_cents, requested_cents):
    if requested_cents > paid_cents:
        raise ValueError("Refund is more than the amount paid")
    return requested_cents
PY
cat > tests/test_pricing.py <<'PY'
import unittest
from src.pricing import apply_discount


class PricingTest(unittest.TestCase):
    def test_ten_percent(self):
        self.assertEqual(apply_discount(1999, 10), 1800)

    def test_cap(self):
        total, pct = 1000, 80
        expected = total - (total * min(pct, 50)) // 100
        self.assertEqual(apply_discount(total, pct), expected)
PY
cat > LANES.md <<'MD'
Lane D: S7.1, S7.2, S7.3 done, tests green.
MD
echo "seed: ok" >&2
