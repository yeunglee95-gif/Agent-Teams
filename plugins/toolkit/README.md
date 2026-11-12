# Toolkit

Skills for any team or app, kept here so a new environment or AI tool gets them by installing one plugin.

| Skill | Use it to |
|---|---|
| `watch` | Watch a video from a URL or file: frames plus a timestamped transcript, or Gemini watching the whole video when a `GEMINI_API_KEY` is set. Needs Python 3.10+, ffmpeg and yt-dlp. |
| `find-skills` | Search the open skills ecosystem (`npx skills find`) and install a vetted skill. A skill found this way joins this toolkit, with its source and licence in `THIRD_PARTY.md`, before any app relies on it. |

**Install:** `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install toolkit@agent-teams`. Where plugins do not install (cloud sessions), copy `skills/*` into the app's `.claude/skills/` from one pinned commit. Codex reads the same folders: copy `skills/*` into the project's `.agents/skills/` or `~/.codex/skills/`.
