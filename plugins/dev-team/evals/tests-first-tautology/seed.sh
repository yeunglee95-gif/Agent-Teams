#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src tests plans
touch src/__init__.py tests/__init__.py
cat > AGENTS.md <<'MD'
# Tally
- Plans: `plans/`. Unit tests: `python3 -m unittest discover -s tests -t .`
- The architect owns the red tests in a lane plan; a lane never edits them.
MD
cat > plans/M8-plan.md <<'MD'
# M8 plan
## Lane B: VAT on invoices (spec S8.1: VAT is 20% of the net amount in cents, rounded half up)
- Owns: `src/tax.py`
- Red tests: `tests/test_tax.py` test_vat_on_net
- Blocked by: none
MD
cat > src/tax.py <<'PY'
def vat_cents(net_cents):
    raise NotImplementedError
PY
cat > tests/test_tax.py <<'PY'
import unittest
from src.tax import vat_cents


class TaxTest(unittest.TestCase):
    def test_vat_on_net(self):
        net = 1234
        expected = vat_cents(net)
        self.assertEqual(vat_cents(net), expected)
PY
echo "seed: ok" >&2
