#!/usr/bin/env bash
set -euo pipefail

# Define vars
GITHUB_ACTIONS=${GITHUB_ACTIONS:-false}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

# Define input variables
MT_ENV=$1
MT_TARGET=${2:-build}

pio run --env $MT_ENV --target $MT_TARGET
if [ "$GITHUB_ACTIONS" = "true" ]; then
    # If running in GitHub Actions, copy the build artifacts to the output directory
    mkdir -p $GITHUB_OUTPUT
    echo "build_artifacts=$(pwd)/.pio/build/$MT_ENV" >> $GITHUB_OUTPUT
else
    # If not running in GitHub Actions, just print the build artifacts path
    echo "Build artifacts are located at: $(pwd)/.pio/build/$MT_ENV"
fi
