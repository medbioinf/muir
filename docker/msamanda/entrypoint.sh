#!/usr/bin/env bash

# Ensures that the user running the container has the binary folder in PATH
export PATH=/usr/local/bin:$PATH

# necessary to not require libicu 
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

set -e

exec "$@"
