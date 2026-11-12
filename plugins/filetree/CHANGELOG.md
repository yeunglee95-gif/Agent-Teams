# Changelog

## 0.8.3 (2026-11-12)

- Added to Agent-Teams from upstream `3ce5b1c`, unchanged. The version stays upstream's, because no line of the plugin changed; a change here would bump it with a suffix, as `auto-handoff` does.
- Upstream's `tests/` is now copied too (OS Flow's copy left it out), so `claude plugin test .` runs here. Upstream's CI, git hooks and release process are not copied; `THIRD_PARTY.md` lists them.
