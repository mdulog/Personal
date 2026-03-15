Display the following command menu for this project:

---

# macOS Setup — Command Menu

## Slash Commands

### /implement
Generates a new shell script from requirements, fully compliant with the project's shell scripting rules. Automatically runs `shellcheck` after writing the script and fixes any warnings before finishing.

**Example:**
```
/implement back up my dotfiles to a timestamped folder
```

---

### /check
Audits all shell scripts for compliance with project rules, presents a fix plan, and applies fixes with approval. Also updates README.md and CLAUDE.md to reflect the current state.

**Example:**
```
/check
```

Use `--dry-run` to see the compliance report and fix plan without making any changes:
```
/check --dry-run
```

---

### /tour
Gives a guided walkthrough of the project for engineers who are new to the codebase. Covers the purpose of each file, the two core workflows, shell script rules, and first steps to get productive.

**Example:**
```
/tour
```

---

### /menu
Displays this command menu.

**Example:**
```
/menu
```

---

## Shell Scripts

### bash CreateBrewFile.sh
Snapshots all currently installed Homebrew packages, casks, and VS Code extensions into the `Brewfile`.

**When to use:** Before committing — run this to keep the `Brewfile` in sync with your machine.

**Example:**
```bash
bash CreateBrewFile.sh
```

---

### bash Setup.sh
Bootstraps a new macOS machine by installing Homebrew and everything defined in the `Brewfile`.

**When to use:** On a fresh Mac after cloning this repo.

**Example:**
```bash
bash Setup.sh
```

---

