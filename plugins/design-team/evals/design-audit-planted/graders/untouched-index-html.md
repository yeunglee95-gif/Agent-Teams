---
type: regex
pattern: '^<!doctype html>\n<html lang="en">\n<head>\n  <meta charset="utf-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1">\n  <title>Tally: reminders<\/title>\n  <link rel="stylesheet" href="tokens\.css">\n  <link rel="stylesheet" href="styles\.css">\n<\/head>\n<body>\n  <header class="top">\n    <h1>Reminders<\/h1>\n    <button class="btn-primary" type="button" id="new">New reminder<\/button>\n  <\/header>\n  <hr class="section-rule">\n  <main>\n    <ul class="reminders" id="list" aria-label="Reminders"><\/ul>\n    <p class="due-hint">Reminders go out at 9am on the due date\.<\/p>\n  <\/main>\n  <aside class="drawer" id="drawer" aria-label="Reminder details">\n    <h2>Details<\/h2>\n  <\/aside>\n  <script src="app\.js"><\/script>\n<\/body>\n<\/html>\n$'
match: contains
target:
  source: file
  path: index.html
weight: 1
---

`index.html` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the auditor reports, it never fixes.
