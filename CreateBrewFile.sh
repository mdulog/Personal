#!/bin/bash
set -euo pipefail

# Description: Dumps all currently installed Homebrew packages, casks, and VS Code
# extensions into a Brewfile in the project root. Run this on your existing Mac
# to capture your current setup before committing and pushing.

BREWFILE="Brewfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Validate prerequisites
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is not installed" >&2
  exit 1
fi

# Remove existing Brewfile if present
if [ -e "${SCRIPT_DIR}/${BREWFILE}" ]; then
  echo "Removing existing ${BREWFILE}"
  rm -v "${SCRIPT_DIR}/${BREWFILE}"
else
  echo "${BREWFILE} does not exist, creating fresh"
fi

# Dump currently installed packages into Brewfile
echo "Creating ${BREWFILE}"
brew bundle dump --file="${SCRIPT_DIR}/${BREWFILE}" --verbose

echo "Done. ${BREWFILE} has been updated."
exit 0
