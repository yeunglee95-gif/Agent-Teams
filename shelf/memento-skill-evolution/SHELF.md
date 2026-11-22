# Memento skill evolution (shelved 2026-11-22)

**Source.** github.com/Memento-Teams/Memento-Skills at `ee9b9a4`, `core/skill/evolution/engine.py` and `prompts.py`, Apache-2.0 (`LICENSE`, `NOTICE`). Copied unchanged, as a reference. The rest of Memento is a whole agent app (desktop GUI, chat-app bridges, its own API keys), not a skill, and is left out.

**What it does** (engine.py's own summary): when a task fails, (1) attribute the failure to one skill that was used, (2) ask a model for targeted file-level replacements, (3) apply them to an isolated copy, (4) run structural, unit and synthetic execution gates, (5) deploy on success or keep the original on failure.

**Why not now.** It deploys the rewritten skill automatically. Our rule is that the retro (`run-retro`) only proposes a skill change and the owner approves each one.

**Kept for.** Floki in OS Flow learning from each business user's workflow to improve their skills (Jase, 2026-11-22). Take steps 1 to 4 (attribute, draft a targeted fix, test it on a copy, keep the original on failure) and replace step 5 with the user's approval.
