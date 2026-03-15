You are giving a guided tour of this project to an engineer who is new to the codebase. Walk them through everything they need to understand to be productive here.

Read the following files before starting the tour so your explanations are grounded in the actual current state of the code:
- CLAUDE.md
- README.md
- Setup.sh
- CreateBrewFile.sh
- Brewfile (first 30 lines are enough for context)

Then deliver the tour in the following structure:

---

# Project Tour: macOS Setup Scripts

## 1. What Is This Repo?
Explain the purpose of the project in 2–3 sentences. Who would use it and when?

## 2. File Map
Walk through every file in the repo and explain what it does and why it exists. For each `.sh` file, describe:
- Its inputs and outputs
- When you'd run it
- Any important flags or behaviors to be aware of

## 3. The Two Core Workflows
Explain the two main things an engineer might do here:
1. **Saving a setup** — when and how to run `CreateBrewFile.sh`, and what to do afterward
2. **Restoring a setup** — when and how to run `Setup.sh`, and what to expect

## 4. Shell Script Rules (What You Must Follow)
Summarize the key coding rules from CLAUDE.md that apply to any `.sh` file in this repo. Cover:
- Required script header
- Naming conventions
- Error handling patterns
- How to validate prerequisites
- The `shellcheck` requirement

Explain *why* each rule exists, not just what it is — this helps new engineers internalize the standards rather than just copy them.

## 5. How to Make Changes
Walk through the workflow for adding or modifying a shell script:
1. What to do before writing code
2. How to write a compliant script (or use `/implement`)
3. How to verify compliance (using `/check` or `shellcheck` directly)
4. How to commit and keep the `Brewfile` up to date

## 6. Available Slash Commands
List the slash commands available in this project and when to use each one. Keep it brief — `/menu` has full details.

## 7. First Steps for a New Engineer
Give 3–5 concrete, actionable things a new engineer should do first to get oriented and ready to contribute.

---

End the tour by inviting them to ask follow-up questions or use `/menu` to see available commands.
