# macOS Setup Scripts

This project contains scripts and configuration for bootstrapping a new macOS machine using Homebrew.

## Files

- **Brewfile** — Snapshot of all installed packages (taps, brews, casks, VS Code extensions)
- **CreateBrewFile.sh** — Dumps currently installed packages into `Brewfile`
- **Setup.sh** — Installs Homebrew and all packages from `Brewfile` on a new machine

## Workflow

### Saving your current setup
```bash
bash CreateBrewFile.sh
```
Run this on your existing Mac to update the `Brewfile` with your current installs, then commit and push.

### Setting up a new Mac
```bash
bash Setup.sh
```
Run this on a fresh Mac. It will:
1. Install Homebrew
2. Configure PATH for Apple Silicon or Intel
3. Install all packages from `Brewfile`
4. Configure global git credentials

## Shell Script Rules

All `.sh` files in this repo must follow these rules:

### Required header
Every script must start with:
```bash
#!/bin/bash
set -euo pipefail
```
- `set -e` — exit immediately on any command failure
- `set -u` — treat unset variables as errors
- `set -o pipefail` — catch failures inside pipes

### Constants
- Use `SCREAMING_SNAKE_CASE` for constants and file path variables
- Define repeated values (like `"Brewfile"`) as a named constant at the top of the script
- Use `SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"` to resolve paths relative to the script, not the caller's working directory

### Validate prerequisites
- Check that required commands exist before using them (e.g. `brew`, `git`)
- Use `command -v <tool> &>/dev/null` for checks
- Exit with a descriptive error message and `exit 1` if a requirement is missing

### Error output
- Send error messages to stderr: `echo "Error: ..." >&2`
- Use `exit 0` for success, `exit 1` for general errors

### Variables
- Always quote variables: use `"$VAR"` not `$VAR`
- Never leave paths or strings unquoted

### Comments
- Add a comment block at the top of each script describing its purpose
- Add inline comments for any non-obvious logic

### Validation
- After every change to a `.sh` file, run `shellcheck <filename>` and fix all warnings before considering the change complete
- If `shellcheck` is not installed, install it first: `brew install shellcheck`
- Zero `shellcheck` warnings is the required standard — do not suppress warnings without a clear justification

### Example script structure
```bash
#!/bin/bash
set -euo pipefail

# Description: What this script does

BREWFILE="Brewfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Validate prerequisites
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is not installed" >&2
  exit 1
fi

# Script logic here
```

## Notes

- Both scripts must be run from the project root directory (where `Brewfile` lives)
- `Setup.sh` requires an internet connection
- On Apple Silicon Macs, Homebrew installs to `/opt/homebrew`; on Intel Macs it installs to `/usr/local`
- After running `Setup.sh`, restart your terminal or run `source ~/.zshrc` for PATH changes to take effect
