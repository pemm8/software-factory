#!/usr/bin/env bash
# The repo's checks. Exit 0 only when the branch is fit to review.
#
# The gate runs this script from the main checkout with the job's worktree as
# the working directory. Keep it fast, deterministic and non-interactive: no
# watch modes, no prompts, nothing that rewrites files.
#
# This repo has no application code yet, so the checks cover the factory itself.
# When an app lands, add its lint, typecheck, test and build commands below.
set -euo pipefail

# Config parses.
python3 -m json.tool factory/config.json >/dev/null

# Scripts are valid Python and shell, without writing .pyc files.
for script in factory/bin/job factory/bin/gate factory/bin/route; do
  python3 -c 'import ast, sys; ast.parse(open(sys.argv[1]).read())' "$script"
done
bash -n factory/checks.sh

# Agent files only use the frontmatter keys Claude Code honours; it ignores
# unknown keys silently, so a typo would quietly change behaviour.
python3 - <<'EOF'
import pathlib
import sys

allowed = {"name", "description", "tools", "model", "hooks"}
bad = []
for path in sorted(pathlib.Path(".claude/agents").glob("*.md")):
    front = path.read_text().split("---")[1]
    keys = {line.split(":")[0] for line in front.splitlines() if line and not line.startswith(" ")}
    if keys - allowed:
        bad.append(f"{path}: unknown keys {sorted(keys - allowed)}")
if bad:
    sys.exit("\n".join(bad))
EOF
