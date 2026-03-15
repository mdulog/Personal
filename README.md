# macOS Setup

A simple set of scripts to backup and restore all your macOS applications and tools using Homebrew.

## Requirements

- macOS

## Files

| File | Description |
|------|-------------|
| `Brewfile` | Snapshot of all installed packages (taps, brews, casks, VS Code extensions) |
| `CreateBrewFile.sh` | Dumps currently installed packages into `Brewfile` |
| `Setup.sh` | Installs Homebrew and all packages from `Brewfile` on a new machine |

## Usage

### Backup your current setup

Run this on your existing Mac to capture everything currently installed:

```bash
bash CreateBrewFile.sh
```

Commit and push the updated `Brewfile` to keep it in sync.

### Restore on a new Mac

Clone this repo, then run:

```bash
bash Setup.sh
```

This will:
1. Install Homebrew
2. Add Homebrew to PATH (supports both Apple Silicon and Intel)
3. Install all packages, casks, and VS Code extensions from `Brewfile`
4. Set global git name and email

## What Gets Installed

The `Brewfile` captures:

- **Taps** — third-party Homebrew repositories
- **Brews** — CLI tools and libraries (e.g. `git`, `node`, `awscli`, `go`)
- **Casks** — GUI applications (e.g. VS Code, Docker, Slack, Zoom)
- **VS Code Extensions** — all installed extensions

## Notes

- Both scripts must be run from the repo root where `Brewfile` lives
- After `Setup.sh` completes, restart your terminal for all PATH changes to take effect
- Re-run `CreateBrewFile.sh` any time you install new apps to keep the `Brewfile` up to date
