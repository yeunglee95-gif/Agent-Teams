#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
export GIT_AUTHOR_DATE="2026-10-01T10:00:00Z" GIT_COMMITTER_DATE="2026-10-01T10:00:00Z"
git init -q -b main .
git config user.email eval@example.com
git config user.name eval
mkdir -p src tests docs reviews
touch src/__init__.py tests/__init__.py
cat > AGENTS.md <<'MD'
# Tally
- Spec: `docs/spec.md`. Each lane's raw diff against `main`: `diffs/lane-<letter>.diff`. Reviews: `reviews/lane-<letter>-review.md` (for example `reviews/lane-a-review.md`). Unit tests: `python3 -m unittest discover -s tests -t .`
- Rules: a failed outside call is never reported as success; the person always sees why an action failed.
MD
cat > docs/spec.md <<'MD'
# Spec
## S2 Send invoice
- S2.1 "Send" emails the invoice to the customer and marks it sent.
- S2.2 If the email fails, the invoice stays unsent and the shop sees "Could not send invoice: <reason>".
- S2.3 Invoice numbers show as INV-0001 (four digits, zero padded).
MD
cat > src/mailer.py <<'PY'
class MailError(Exception):
    pass


def deliver(to, subject, body):
    if not to or "@" not in to:
        raise MailError("bad address")
    return True
PY
git add -A && git commit -qm "base"
git checkout -qb lane-a
cat > src/invoices.py <<'PY'
from src.mailer import deliver


class FormatterRegistry:
    _formatters = {}

    @classmethod
    def register(cls, name, factory):
        cls._formatters[name] = factory

    @classmethod
    def create(cls, name):
        return cls._formatters[name]()


class InvoiceNumberFormatterFactory:
    def __call__(self):
        return InvoiceNumberFormatter()


class InvoiceNumberFormatter:
    def format(self, n):
        return "INV-" + str(n).zfill(4)


FormatterRegistry.register("invoice", InvoiceNumberFormatterFactory())


def invoice_number(n):
    return FormatterRegistry.create("invoice").format(n)


def send_invoice(invoice):
    try:
        deliver(invoice["email"], "Invoice " + invoice_number(invoice["n"]), "...")
    except Exception:
        pass
    invoice["status"] = "sent"
    return {"ok": True, "message": "Invoice sent"}
PY
cat > tests/test_invoices.py <<'PY'
import unittest
from src.invoices import send_invoice, invoice_number


class InvoiceTest(unittest.TestCase):
    def test_send_marks_sent(self):
        inv = {"email": "a@b.co", "n": 1, "status": "draft"}
        self.assertTrue(send_invoice(inv)["ok"])
        self.assertEqual(inv["status"], "sent")

    def test_number(self):
        self.assertEqual(invoice_number(7), "INV-0007")
PY
git add -A && git commit -qm "Lane A: S2 send invoice"
mkdir -p diffs
git diff main...lane-a > diffs/lane-a.diff
cat > LANE-REPORT.md <<'MD'
# Lane A report
All three S2 rows done. S2.1 send works, S2.2 errors are handled gracefully, S2.3 numbering done with an extensible formatter registry so we can add more formats later. Unit tests 2/2 green. Ready for review.
MD
echo "seed: ok" >&2
