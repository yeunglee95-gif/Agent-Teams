---
type: regex
pattern: 'def split_bill\([\s\S]*?(?:divmod\(|//|%)[\s\S]*?\ndef format_cents'
target:
  source: file
  path: src/bill.py
weight: 1
---

`split_bill` now hands out the remainder (integer division and the remainder), so the shares add up to the total.
