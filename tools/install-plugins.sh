#!/usr/bin/env bash
# Installs plugins from this checkout of Agent-Teams for the current user, reading the list from
# .claude-plugin/marketplace.json, so a new plugin needs no edit here. With names, installs only those:
#   bash tools/install-plugins.sh                         every plugin in the marketplace
#   bash tools/install-plugins.sh crew-progress forge     just these
# Use it where `/plugin marketplace add` cannot reach this private repo, such as a cloud setup script
# working from a pinned clone. Safe to run again: it refreshes the marketplace and updates each plugin.
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
command -v claude >/dev/null || { echo "install-plugins: no claude CLI, skipped"; exit 0; }
command -v node >/dev/null || { echo "install-plugins: node is needed to read the marketplace" >&2; exit 1; }
read -r market all < <(node -e '
  const m = require(process.argv[1]);
  console.log(m.name, m.plugins.map(p => p.name).join(" "));
' "$root/.claude-plugin/marketplace.json")
wanted=("$@")
[ ${#wanted[@]} -eq 0 ] && read -r -a wanted <<< "$all"
for p in "${wanted[@]}"; do
  [[ " $all " == *" $p "* ]] || { echo "install-plugins: $p is not in $market's marketplace ($all)" >&2; exit 1; }
done
claude plugin marketplace add "$root" >/dev/null 2>&1 || claude plugin marketplace update "$market" >/dev/null
failed=()
for p in "${wanted[@]}"; do
  claude plugin install "$p@$market" >/dev/null 2>&1 || claude plugin update "$p@$market" >/dev/null 2>&1 || failed+=("$p")
done
claude plugin list 2>/dev/null | grep -F -e "@$market" || echo "install-plugins: none listed"
[ ${#failed[@]} -eq 0 ] || { echo "install-plugins: failed: ${failed[*]}" >&2; exit 1; }
