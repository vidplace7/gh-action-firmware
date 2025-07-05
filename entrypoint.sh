#!/usr/bin/env bash
set -euo pipefail

# Define vars
GITHUB_ACTIONS=${GITHUB_ACTIONS:-false}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

pio run --env $MT_ENV --target $MT_TARGET
if [ "$GITHUB_ACTIONS" = "true" ]; then
    # If running in GitHub Actions, copy the build artifacts to the output directory
    echo "build_artifacts=$PLATFORMIO_BUILD_DIR" >> $GITHUB_OUTPUT
    echo $(ls -lah $PLATFORMIO_BUILD_DIR)
else
    # If not running in GitHub Actions, just print the build artifacts path
    echo "Build artifacts are located at: $PLATFORMIO_BUILD_DIR"
fi
