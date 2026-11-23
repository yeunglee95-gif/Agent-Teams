#!/usr/bin/env python3
"""Replay test for the decide skill.

Each case in cases.jsonl is a past ask with Jase's pick and reason hidden. The
runner asks a model to choose twice, once with the skill and once without, and
scores agreement with his real pick.

Backends:
  --backend cmd --cmd "codex exec -"   pipe each prompt to a command, read stdout
  --backend cmd --cmd "claude -p"      the same with Claude Code
  --backend openai --model <id>        the OpenAI chat API (key from OPENAI_API_KEY or a proxy)
  --backend files --out <dir>          write prompts only, for a model run elsewhere
                                       (for example Claude's Agent tool); put each
                                       answer in <dir>/<case>.<arm>.answer, then
                                       run `score --out <dir>`

Usage:
  python3 run.py run --backend cmd --cmd "codex exec -" --label codex
  python3 run.py score --out answers/ --label claude
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


def skill_text():
    return "\n\n".join((SKILL / f).read_text() for f in ("SKILL.md", "principles.md", "calibration.md"))


def prompt(case, arm):
    opts = "\n".join(f"- {o['key']}: {o['text']}" for o in case["options"])
    rec = f"\nThe assistant recommended: {case['recommended']}\n" if case.get("recommended") else ""
    head = ""
    if arm == "with":
        head = "Use this skill to decide as Jase would.\n\n<skill>\n" + skill_text() + "\n</skill>\n\n"
    return (
        head
        + "You are choosing on behalf of Jase, a founder, the option he picked.\n\n"
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
    ap.add_argument("--cases", default=str(HERE / "cases.jsonl"))
    ap.add_argument("--backend", choices=("cmd", "openai", "files"), default="files")
    ap.add_argument("--cmd")
    ap.add_argument("--model")
    ap.add_argument("--out", default=str(HERE / "results"))
    ap.add_argument("--label", default="model")
    args = ap.parse_args()

    cases = load_cases(pathlib.Path(args.cases))
    out = pathlib.Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    answers = {}

    if args.mode == "run":
        for c in cases:
            for a in ARMS:
                p = prompt(c, a)
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
