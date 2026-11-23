#!/usr/bin/env python3
"""Replay test for the decide skill.

Each case is a past ask with the owner's pick and reason hidden. The runner
asks a model to choose twice, once with the skill (SKILL.md plus the project's
principles.md and overrides.md) and once without, and scores agreement with
the real pick. Cases, principles, overrides and results all stay in the
project, never in Agent-Teams.

Inputs (from the project, for example context/decide/):
  principles.md   ranked principles (format: skills/decide/templates/principles.md)
  overrides.md    override log (format: skills/decide/templates/overrides.md)
  cases.jsonl     one JSON object per line:
    id           string, unique, used in file names
    date         YYYY-MM-DD
    context      what was going on, as the owner saw it
    question     the ask
    options      list of {"key": "a", "text": "..."}
    recommended  key of the option recommended to the owner, or null
    pick         key the owner picked (hidden from the model)
    reason       the owner's words (hidden from the model; kept for review)

Backends:
  --backend cmd --cmd "codex exec -"   pipe each prompt to a command, read stdout
  --backend cmd --cmd "claude -p"      the same with Claude Code
  --backend openai --model <id>        the OpenAI chat API (key from OPENAI_API_KEY or a proxy)
  --backend files --out <dir>          write prompts only, for a model run elsewhere
                                       (for example Claude's Agent tool); put each
                                       answer in <dir>/<case>.<arm>.answer, then
                                       run `score --out <dir>`

Usage:
  python3 run.py run --context ctx/ --out res/ --backend cmd --cmd "codex exec -" --label codex
  python3 run.py run --context ctx/ --out res/                # write prompt files
  python3 run.py score --context ctx/ --out res/ --label claude
"""
import argparse, json, os, pathlib, re, subprocess, sys, urllib.request

HERE = pathlib.Path(__file__).resolve().parent
SKILL = HERE.parents[1] / "skills" / "decide"
ARMS = ("with", "without")


def load_cases(path):
    cases = []
    for line in path.read_text().splitlines():
        if line.strip():
            cases.append(json.loads(line))
    return cases


def skill_text(ctx):
    parts = [(SKILL / "SKILL.md").read_text()]
    for f in ("principles.md", "overrides.md"):
        path = ctx / f
        if path.exists():
            parts.append(f"<{f}>\n" + path.read_text() + f"\n</{f}>")
        else:
            print(f"warning: no {path}", file=sys.stderr)
    return "\n\n".join(parts)


def prompt(case, arm, ctx, owner):
    opts = "\n".join(f"- {o['key']}: {o['text']}" for o in case["options"])
    rec = f"\nThe assistant recommended: {case['recommended']}\n" if case.get("recommended") else ""
    head = ""
    if arm == "with":
        head = f"Use this skill to decide as {owner} would.\n\n<skill>\n" + skill_text(ctx) + "\n</skill>\n\n"
    return (
        head
        + f"Predict the option {owner} picked.\n\n"
        + f"Context: {case['context']}\n\nQuestion: {case['question']}\n\nOptions:\n{opts}\n{rec}\n"
        + "Answer with one line, exactly `PICK: <key>`, then at most two lines of reasoning."
    )


def parse(text, keys):
    m = re.search(r"PICK:\s*\**\s*([A-Za-z0-9]+)", text or "")
    if m and m.group(1).lower() in {k.lower() for k in keys}:
        return m.group(1).lower()
    return None


def ask_cmd(cmd, text):
    r = subprocess.run(cmd, shell=True, input=text, capture_output=True, text=True, timeout=600)
    return r.stdout


def ask_openai(model, text):
    body = json.dumps({"model": model, "messages": [{"role": "user", "content": text}]}).encode()
    req = urllib.request.Request(
        "https://api.openai.com/v1/chat/completions",
        data=body,
        headers={"Content-Type": "application/json",
                 "Authorization": "Bearer " + os.environ.get("OPENAI_API_KEY", "proxy-injected")},
    )
    with urllib.request.urlopen(req, timeout=600) as r:
        return json.load(r)["choices"][0]["message"]["content"]


def score(cases, answers, label):
    rows, tally = [], {a: [0, 0] for a in ARMS}
    for c in cases:
        keys = [o["key"] for o in c["options"]]
        row = {"id": c["id"], "truth": c["pick"].lower()}
        for a in ARMS:
            got = parse(answers.get((c["id"], a)), keys)
            row[a] = got
            if answers.get((c["id"], a)) is not None:
                tally[a][1] += 1
                tally[a][0] += got == row["truth"]
        rows.append(row)
    print(f"model: {label}")
    for a in ARMS:
        hit, n = tally[a]
        print(f"  {a} skill: {hit}/{n}" + (f" ({100*hit/n:.0f}%)" if n else ""))
    overrides = [c for c in cases if c.get("recommended") and c["recommended"].lower() != c["pick"].lower()]
    for a in ARMS:
        hit = sum(1 for c in overrides for r in rows if r["id"] == c["id"] and r[a] == r["truth"])
        print(f"  {a} skill on overrides: {hit}/{len(overrides)}")
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=("run", "score"))
    ap.add_argument("--context", required=True, help="the project's decide folder")
    ap.add_argument("--cases", help="default: <context>/cases.jsonl")
    ap.add_argument("--owner", default="the project's owner")
    ap.add_argument("--backend", choices=("cmd", "openai", "files"), default="files")
    ap.add_argument("--cmd")
    ap.add_argument("--model")
    ap.add_argument("--out", required=True, help="results folder, kept in the project")
    ap.add_argument("--label", default="model")
    args = ap.parse_args()

    ctx = pathlib.Path(args.context)
    cases = load_cases(pathlib.Path(args.cases) if args.cases else ctx / "cases.jsonl")
    out = pathlib.Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    answers = {}

    if args.mode == "run":
        for c in cases:
            for a in ARMS:
                p = prompt(c, a, ctx, args.owner)
                if args.backend == "files":
                    (out / f"{c['id']}.{a}.prompt").write_text(p)
                    continue
                text = ask_cmd(args.cmd, p) if args.backend == "cmd" else ask_openai(args.model, p)
                (out / f"{c['id']}.{a}.answer").write_text(text)
                answers[(c["id"], a)] = text
                print(c["id"], a, parse(text, [o["key"] for o in c["options"]]), file=sys.stderr)
        if args.backend == "files":
            print(f"wrote {2*len(cases)} prompts to {out}")
            return
    else:
        for c in cases:
            for a in ARMS:
                f = out / f"{c['id']}.{a}.answer"
                if f.exists():
                    answers[(c["id"], a)] = f.read_text()

    rows = score(cases, answers, args.label)
    (out / f"scores-{args.label}.json").write_text(json.dumps(rows, indent=1))


if __name__ == "__main__":
    main()
