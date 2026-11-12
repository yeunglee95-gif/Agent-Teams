# Third-party skills in the toolkit

| Skill | Source | Commit | Licence | Changes |
|---|---|---|---|---|
| `watch` | [bradautomates/claude-video](https://github.com/bradautomates/claude-video) `skills/watch` | `03ceb42` | MIT, `licenses/claude-video-MIT.txt` | A `## Source` section added to SKILL.md |
| `find-skills` | [vercel-labs/skills](https://github.com/vercel-labs/skills) `skills/find-skills` | `e781cb4` | MIT, `licenses/vercel-skills-MIT.txt` | A `## Source` section added to SKILL.md |

**Checked before adding (2026-11-12):** the watch scripts call only yt-dlp, ffmpeg, Google's Gemini API (only when a Gemini key is set), Groq or OpenAI transcription (only when chosen), and the uv, PyTorch and Hugging Face installers (only for the optional local WhisperX setup). Nothing runs at install. The upstream plugin's SessionStart hook is not copied, so installing the toolkit adds no hook.
