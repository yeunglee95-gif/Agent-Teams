---
type: regex
pattern: '^<!doctype html>\n<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Tally · Home<\/title><link rel="stylesheet" href="styles\.css"><\/head>\n<body>\n<header><h1>Tally<\/h1><button class="btn" type="button">New invoice<\/button><\/header>\n<div class="layout">\n<nav aria-label="Main"><a href="index\.html" class="on">Home<\/a><a href="hub\.html">Hub<\/a><a href="reports\.html">Reports<\/a><a href="#new">\+ New invoice<\/a><\/nav>\n<main>\n<h2>Home<\/h2>\n<table><thead><tr><th>Client<\/th><th>Amount<\/th><th>Due<\/th><\/tr><\/thead><tbody><tr><td>Rosa''s Bakery<\/td><td>\$240\.00<\/td><td>Oct 3<\/td><\/tr><tr><td>Green Leaf Florist<\/td><td>\$85\.50<\/td><td>Oct 12<\/td><\/tr><tr><td>Harbor Books<\/td><td>\$410\.00<\/td><td>Oct 20<\/td><\/tr><\/tbody><\/table>\n<\/main>\n<\/div>\n<button class="fab" type="button" aria-label="New invoice">\+<\/button>\n<\/body><\/html>\n$'
match: contains
target:
  source: file
  path: index.html
weight: 1
---

`index.html` is byte for byte as seeded (sha256 in `.git/seed.sha256`): the design-critic reports, it never fixes.
