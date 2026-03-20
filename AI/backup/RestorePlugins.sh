#!/bin/bash
set -euo pipefail

# Description: Restores AI plugin configuration files from a backup archive in AI/backup/.
# By default, restores from the most recent archive. Pass an archive filename as the first
# argument to restore from a specific backup.
#
# Usage:
#   bash RestorePlugins.sh                          # restore latest backup
#   bash RestorePlugins.sh plugins_2026-01-01_120000.tar.gz  # restore specific backup
#
# Inputs:  Optional: archive filename (basename only, must live in AI/backup/)
# Outputs: Restored CLAUDE*.md files extracted into AI/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AI_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
BACKUP_DIR="${SCRIPT_DIR}"

# Validate prerequisites
if ! command -v tar &>/dev/null; then
  echo "Error: 'tar' is not installed or not in PATH" >&2
  exit 1
fi

# Resolve which archive to restore
if [ "${#}" -ge 1 ]; then
  # Specific archive requested — accept basename only for safety
  ARCHIVE_PATH="${BACKUP_DIR}/$(basename "${1}")"
  if [ ! -f "${ARCHIVE_PATH}" ]; then
    echo "Error: Archive not found: ${ARCHIVE_PATH}" >&2
    exit 1
  fi
else
  # No argument — pick the most recent archive by filename (timestamps sort lexically)
  LATEST="$(find "${BACKUP_DIR}" -maxdepth 1 -name "plugins_*.tar.gz" -type f | sort | tail -n 1)"
  if [ -z "${LATEST}" ]; then
    echo "Error: No backup archives found in '${BACKUP_DIR}'" >&2
    exit 1
  fi
  ARCHIVE_PATH="${LATEST}"
fi

ARCHIVE_NAME="$(basename "${ARCHIVE_PATH}")"

echo "Restoring from: ${ARCHIVE_NAME}"
echo "Destination:    ${AI_DIR}"

# List files that will be restored
echo "Files to restore:"
tar -tzf "${ARCHIVE_PATH}" | while IFS= read -r FILE; do
  echo "  - ${FILE}"
done

# Extract into AI/ directory (overwrites existing files)
tar -xzf "${ARCHIVE_PATH}" -C "${AI_DIR}"

echo "Restore complete."
exit 0
