Audit all project shell scripts for compliance with CLAUDE.md rules, then update documentation to reflect the current state.

Accept an optional argument:
- (no argument) — audit, present a fix plan, and apply fixes one at a time with user approval, then update docs
- `--dry-run` — audit only, display the compliance report and proposed fixes, make no changes

---

## Step 1: Audit shell scripts for compliance

Read each `.sh` file in the project and check it against every rule in CLAUDE.md:

### Checklist per script
- [ ] Starts with `#!/bin/bash` on line 1
- [ ] Second line is `set -euo pipefail`
- [ ] Has a comment block describing the script's purpose
- [ ] Constants are in `SCREAMING_SNAKE_CASE`
- [ ] Repeated values (like filenames) are defined as named constants
- [ ] Uses `SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"` for relative paths
- [ ] Validates all required commands with `command -v <tool> &>/dev/null` before use
- [ ] Errors are sent to stderr: `echo "Error: ..." >&2`
- [ ] Exits with `exit 0` on success, `exit 1` on error
- [ ] All variables are quoted: `"$VAR"` not `$VAR`
- [ ] No unquoted paths or strings
- [ ] Inline comments exist for any non-obvious logic

---

## Step 2: Display compliance report

For each script, output a report in this format:

```
## Compliance Report: <filename>

✅ PASS — <rule>
❌ FAIL — <rule>
   Issue: <what specifically is wrong>
   Fix:   <what needs to change>
```

If all scripts are fully compliant, say so and stop here.

---

## Step 3: Present fix plan

Summarize all violations as a numbered fix plan before making any changes:

```
## Fix Plan

1. <filename> — <rule violated> → <what will change>
2. <filename> — <rule violated> → <what will change>
...
```

If `--dry-run` was passed, stop here. Do not apply any changes.

---

## Step 4: Apply fixes

For each item in the fix plan:
1. Show the proposed change (diff-style: what will change)
2. Ask: "Apply this fix? (yes/no)"
3. If yes — apply the edit
4. If no — skip and move to the next item

Handle fixes one at a time. Do not batch.

---

## Step 5: Update documentation

1. Read the current `README.md` and `CLAUDE.md`
2. Read the current `Brewfile`, `CreateBrewFile.sh`, and `Setup.sh`
3. Identify anything in the docs that is outdated, missing, or incorrect
4. Update only the sections that need to change — leave accurate sections untouched
