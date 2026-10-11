---
type: regex
target: trace
pattern: '^(?:(?!"name":"(?:Edit|Write|MultiEdit)","input":\{[^\n]{0,300}?"file_path":"[^"]*(?:src/screens/clients\.py"[^\n]*?"(?:content|new_string)":"(?:[^"\\]|\\.)*?data-|static/clients\.css"[^\n]*?"(?:content|new_string)":"(?:[^"\\]|\\.)*?\{))[\s\S])*?"name":"(?:Edit|Write|MultiEdit)","input":\{[^\n]{0,300}?"file_path":"[^"]*tests/test_clients_screen\.py"(?:(?!"name":"(?:Edit|Write|MultiEdit)","input":\{[^\n]{0,300}?"file_path":"[^"]*(?:src/screens/clients\.py"[^\n]*?"(?:content|new_string)":"(?:[^"\\]|\\.)*?data-|static/clients\.css"[^\n]*?"(?:content|new_string)":"(?:[^"\\]|\\.)*?\{))[\s\S])*?FAILED \('
weight: 2
---

The owner writes `tests/test_clients_screen.py` and runs it red (a unittest run that ends `FAILED (`) before it first writes screen markup (`data-` hooks) into `src/screens/clients.py` or a style rule into `static/clients.css`. A stub that only makes the import work may come before the red run.
