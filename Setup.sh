#!/bin/bash
set -euo pipefail

# Description: Bootstraps a new macOS machine by installing Homebrew and all
# packages, casks, and VS Code extensions defined in the Brewfile. Run this
# on a fresh Mac after cloning this repo.

BREWFILE="Brewfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Validate Brewfile exists
if [ ! -f "${SCRIPT_DIR}/${BREWFILE}" ]; then
  echo "Error: ${BREWFILE} not found in ${SCRIPT_DIR}" >&2
  exit 1
fi

# Validate curl is available (required to download Homebrew installer)
if ! command -v curl &>/dev/null; then
  echo "Error: curl is required to install Homebrew but was not found" >&2
  exit 1
fi

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping"
fi

# Add Homebrew to PATH — required on Apple Silicon; harmless on Intel
if [[ "$(uname -m)" == "arm64" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
else
  BREW_BIN="/usr/local/bin/brew"
fi

if [ ! -x "${BREW_BIN}" ]; then
  echo "Error: brew not found at ${BREW_BIN} after installation" >&2
  exit 1
fi

eval "$("${BREW_BIN}" shellenv)"

# Install all packages from Brewfile
echo "Installing packages from ${BREWFILE}..."
brew bundle install --file="${SCRIPT_DIR}/${BREWFILE}"

# Configure git globals
git config --global user.name "mdulog"
git config --global user.email "madulog@gmail.com"

echo "Done. Restart your terminal for all PATH changes to take effect."
