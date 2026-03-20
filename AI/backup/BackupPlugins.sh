#!/bin/bash
set -euo pipefail

# Description: Backs up all AI plugin configuration files (CLAUDE*.md) from the AI/
# directory into a timestamped archive in AI/backup/. Safe to run repeatedly — each
# run creates a new dated snapshot without overwriting previous backups.
#
# Inputs:  None
# Outputs: AI/backup/plugins_YYYY-MM-DD_HHMMSS.tar.gz

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AI_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

BACKUP_DIR="${SCRIPT_DIR}"
TIMESTAMP="$(date +%Y-%m-%d_%H%M%S)"
ARCHIVE_NAME="plugins_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${BACKUP_DIR}/${ARCHIVE_NAME}"

# Glob pattern for plugin files to back up
PLUGIN_PATTERN="CLAUDE*.md"

# Validate prerequisites
if ! command -v tar &>/dev/null; then
  echo "Error: 'tar' is not installed or not in PATH" >&2
  exit 1
fi

echo "Scanning for plugin files matching '${PLUGIN_PATTERN}' in: ${AI_DIR}"

# Collect matching filenames relative to AI_DIR (bash 3.2-compatible)
PLUGIN_NAMES=()
while IFS= read -r -d '' FILE; do
  PLUGIN_NAMES+=("$(basename "${FILE}")")
done < <(find "${AI_DIR}" -maxdepth 1 -iname "${PLUGIN_PATTERN}" -type f -print0)

if [ "${#PLUGIN_NAMES[@]}" -eq 0 ]; then
  echo "Error: No plugin files found matching '${PLUGIN_PATTERN}' in '${AI_DIR}'" >&2
  exit 1
fi

echo "Found ${#PLUGIN_NAMES[@]} plugin file(s):"
for NAME in "${PLUGIN_NAMES[@]}"; do
  echo "  - ${NAME}"
done

# Create the backup archive, storing paths relative to AI_DIR
echo "Creating backup archive: ${ARCHIVE_NAME}"
tar -czf "${ARCHIVE_PATH}" -C "${AI_DIR}" "${PLUGIN_NAMES[@]}"

echo "Backup complete: ${ARCHIVE_PATH}"
exit 0
