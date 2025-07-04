#!/usr/bin/env bash
set -euo pipefail

platformio project config --json-output | jq -r '.[] | select(.[0] | type == "string" and startswith("env:")) | .[0] | ltrimstr("env:")' | while read -r env; do
    echo "################################################"
    echo "Loading targets for environment: $env"
    echo "################################################"
    pio pkg install --environment "$env"
done
echo "All targets loaded successfully."

# Replace duplicate files in the core directory with hard links
echo "Deduplicating $PLATFORMIO_CORE_DIR"
jdupes --quiet -r -L "$PLATFORMIO_CORE_DIR"

# Replace duplicate files in the workspace directory with hard links
echo "Deduplicating $PLATFORMIO_WORKSPACE_DIR"
jdupes --quiet -r -L "$PLATFORMIO_WORKSPACE_DIR"

echo "Deduplication complete."
