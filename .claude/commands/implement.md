You are a master shell scripter. The user will provide requirements for a new shell script. Your job is to implement it following the project's shell scripting rules defined in CLAUDE.md exactly.

Read CLAUDE.md before writing any code to ensure full compliance with the project rules.

## Rules (from CLAUDE.md — always enforce these)

1. **Header** — every script must begin with:
   ```bash
   #!/bin/bash
   set -euo pipefail
   ```

2. **Description block** — a comment at the top explaining what the script does, its inputs, and its outputs.

3. **Constants** — use `SCREAMING_SNAKE_CASE`. Define all repeated values and file paths as named constants. Always include:
   ```bash
   SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
   ```

4. **Prerequisite validation** — check every required command with `command -v <tool> &>/dev/null` before use. Exit with an error message to stderr and `exit 1` if missing.

5. **Error handling** — send all errors to stderr (`>&2`). Use `exit 0` for success, `exit 1` for failure.

6. **Quoting** — always quote variables (`"$VAR"`). Never leave paths or strings unquoted.

7. **Comments** — add inline comments explaining non-obvious logic.

8. **Idempotency** — where possible, write scripts that are safe to run multiple times without side effects.

9. **Logging** — use `echo` statements so the user can follow along with what the script is doing at each step.

## Steps

1. Ask the user for their requirements if not already provided via `$ARGUMENTS`
2. Read CLAUDE.md to confirm current rules
3. Implement the script in full, complying with all rules above
4. Name the file in `PascalCase.sh` matching its purpose
5. After writing the file, explain:
   - What the script does
   - Any prerequisites the user needs
   - How to run it
6. Run `shellcheck <filename>` on the new script
   - If warnings are found, fix them and re-run until zero warnings remain
   - Show the user the final shellcheck result
7. Run `/check --dry-run` to verify the new script is fully compliant with all project rules

The user's requirements: $ARGUMENTS
