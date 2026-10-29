# zazencodes-software-factory

A software factory for Claude Code, following
<https://github.com/zazencodes/zazencodes-season-3/tree/main/src/software-factory-claude-code-v2>.
The app is a static Todo List: `index.html` + `README.md`, Alpine.js via CDN.

## Setup

Needs `python3` 3.10+, `git`, an authenticated `gh` that can push to this repo,
and Claude Code 2.1.257+. The scripts use only the standard library; there is
nothing to install and no env file.

## Validation

`bash factory/checks.sh` is the only validation command: config parses, the three
scripts parse, and every agent file uses only known frontmatter keys. It must exit
0 on `main`. Add the app's lint, typecheck, test and build commands to it when one
exists, and keep it in sync with this section. The app has no automated checks;
it is verified by the manual checklist in `README.md`.

## Dev server

The app: open `index.html`, or run `python3 -m http.server <port>` from the repo
root and open `/index.html`.

The factory dashboard: `cd factory && python3 -m http.server 5100`, then
open <http://localhost:5100/dashboard.html>. Pass a different port for a job's
worktree (the orchestrator gives each agent one).

## Conventions

- Match the neighbouring code: the scripts are small, stdlib-only Python with a
  module docstring that is also their `--help`.
- `factory/jobs/` is gitignored job state. `factory/bin/job` is its only writer.
- Never edit `factory/checks.sh`, `factory/config.json` or `factory/bin/*` from a
  job: the gate fails the branch (`protected_paths`).

## Software factory

`/factory run` builds every open GitHub issue labeled `factory` through
intake → spec → build → gate → review → approve, one PR per issue. State is in
`factory/jobs/` (gitignored); `factory/bin/job` is its only writer. Checks:
`factory/checks.sh`. Dashboard: `cd factory && python3 -m http.server`, then
open http://localhost:8000/dashboard.html.
