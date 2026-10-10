---
type: regex
pattern: '^import unittest\nfrom src\.tax import vat_cents\n\n\nclass TaxTest\(unittest\.TestCase\):\n    def test_vat_on_net\(self\):\n        net = 1234\n        expected = vat_cents\(net\)\n        self\.assertEqual\(vat_cents\(net\), expected\)\n$'
match: contains
target:
  source: file
  path: tests/test_tax.py
weight: 1
---

The lane does not edit the architect's red test.
