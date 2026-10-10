#!/usr/bin/env python3
"""Build the skill board data from a team plugin at a git ref.

Reads only through `git show` / `git ls-tree`, so the working tree is never touched.
Usage: gen.py <repo> <ref> <plugin-path> <template.html> <out.html>
"""
import json, re, subprocess, sys

repo, ref, plug, template, out = sys.argv[1:6]


def git(*args):
    return subprocess.run(["git", "-C", repo, *args], check=True, capture_output=True, text=True).stdout


def show(path):
    try:
        return git("show", f"{ref}:{plug}/{path}")
    except subprocess.CalledProcessError:
        return None


def ls(path):
    try:
        return [l.split("\t")[1].split("/")[-1] for l in git("ls-tree", f"{ref}:{plug}/{path}").splitlines()]
    except subprocess.CalledProcessError:
        return []


def front(text):
    m = re.match(r"---\n(.*?)\n---\n(.*)", text, re.S)
    if not m:
        return {}, text
    meta, key = {}, None
    for line in m.group(1).splitlines():
        if re.match(r"^\s+-\s+", line) and key:
            meta.setdefault(key, []).append(line.split("-", 1)[1].strip())
        elif ":" in line:
            key, val = line.split(":", 1)
            key, val = key.strip(), val.strip()
            meta[key] = val if val else []
    return meta, m.group(2)


def section(body, title):
    m = re.search(rf"^## {title}\s*\n(.*?)(?=^## |\Z)", body, re.S | re.M)
    return m.group(1).strip() if m else ""


def first_para(body):
    for block in re.split(r"\n\s*\n", body):
        b = block.strip()
        if b and not b.startswith("#"):
            return re.sub(r"\s+", " ", b)
    return ""


commit = git("rev-parse", ref).strip()
plugin = json.loads(show(".claude-plugin/plugin.json"))
issues = []

# THIRD_PARTY.md table: skill -> sources
third = {}
for line in (show("THIRD_PARTY.md") or "").splitlines():
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    if len(cells) == 4 and cells[0] not in ("Skill", "") and not set(cells[0]) <= set("-: "):
        name, frm, com, lic = cells
        frms, coms, lics = [x.strip() for x in frm.split(";")], [x.strip() for x in com.split(";")], [x.strip() for x in lic.split(";")]
        srcs = []
        for i, f in enumerate(frms):
            rm = re.match(r"([\w.-]+/[\w.-]+)\s*(.*)", f)
            srcs.append({
                "repo": rm.group(1) if rm else f,
                "path": (rm.group(2) if rm else "").replace("`", "").strip(),
                "commit": coms[i] if i < len(coms) else coms[-1],
                "license": lics[i] if i < len(lics) else lics[-1],
            })
        third[name.replace("`", "").split(" ")[0]] = srcs

skills = {}
for name in ls("skills"):
    text = show(f"skills/{name}/SKILL.md")
    if text is None:
        continue
    meta, body = front(text)
    src_text = section(body, "Source")
    m = re.search(r"Changed:\s*(.*?)(?:License text|$)", src_text, re.S)
    changed = re.sub(r"\s+", " ", m.group(1)).strip() if m else ""
    sources = third.get(name, [])
    if not src_text:
        issues.append(f"Skill {name} has no Source section")
    if src_text and not sources and "own" not in src_text.lower():
        issues.append(f"Skill {name} is not listed in THIRD_PARTY.md")
    title = re.search(r"^# (.+)$", body, re.M)
    skills[name] = {
        "id": name,
        "title": title.group(1).strip() if title else name,
        "what": meta.get("description", ""),
        "lead": first_para(body.split("\n", 2)[-1] if title else body),
        "sources": sources,
        "authors": sorted({s["repo"].split("/")[0] for s in sources}) or ["own"],
        "changed": changed,
        "sourceText": re.sub(r"\s+", " ", src_text),
        "path": f"{plug}/skills/{name}/SKILL.md",
        "usedBy": [],
    }

roles = []
for f in sorted(ls("agents")):
    if not f.endswith(".md"):
        continue
    meta, body = front(show(f"agents/{f}"))
    rid = meta.get("name", f[:-3])
    sk = meta.get("skills", []) or []
    if isinstance(sk, str):
        sk = [sk]
    for s in sk:
        if s in skills:
            skills[s]["usedBy"].append(rid)
        else:
            issues.append(f"Role {rid} loads {s}, which does not exist")
    tools = meta.get("tools", "")
    roles.append({
        "id": rid,
        "what": meta.get("description", ""),
        "model": meta.get("model", ""),
        "tools": tools if isinstance(tools, str) else ", ".join(tools),
        "skills": sk,
        "path": f"{plug}/agents/{f}",
    })

for s in skills.values():
    if not s["usedBy"]:
        issues.append(f"Skill {s['id']} is loaded by no role")

# Rejected candidates: markdown table rows in REJECTED.md (skills/ or plugin root)
rejected = []
rej_text = show("skills/REJECTED.md") or show("REJECTED.md") or ""
header = None
for line in rej_text.splitlines():
    if not line.strip().startswith("|"):
        continue
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    if set("".join(cells)) <= set("-: "):
        continue
    if header is None:
        header = [c.lower() for c in cells]
        continue
    rejected.append(dict(zip(header, cells)))

# The loop: table rows in workflows/milestone-loop.md
loop = []
loop_text = show("workflows/milestone-loop.md") or ""
lh = None
for line in loop_text.splitlines():
    if not line.strip().startswith("|"):
        if lh and loop:
            break
        continue
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    if set("".join(cells)) <= set("-: "):
        continue
    if lh is None:
        lh = [c.lower() for c in cells]
        continue
    loop.append(dict(zip(lh, cells)))

licenses = ls("licenses")
evals = [e for e in ls("evals") if e not in ("results", "README.md") and not e.startswith(".")]

data = {
    "team": {
        "name": plugin.get("name"), "version": plugin.get("version"),
        "description": plugin.get("description", ""),
        "repo": "yeunglee95-gif/agent-teams", "ref": ref, "commit": commit,
    },
    "roles": roles,
    "skills": sorted(skills.values(), key=lambda s: s["id"]),
    "rejected": rejected,
    "loopHeader": lh or [],
    "loop": loop,
    "licenses": licenses,
    "evals": evals,
    "issues": issues,
}
html = open(template).read().replace("/*__DATA__*/null", json.dumps(data, ensure_ascii=False).replace("</", "<\\/"))
open(out, "w").write(html)
print(f"{len(roles)} roles, {len(skills)} skills, {len(rejected)} rejected, {len(loop)} loop rows, {len(issues)} issues")
for i in issues:
    print(" -", i)
