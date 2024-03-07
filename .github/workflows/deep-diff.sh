#!/bin/bash
# This script lists files that have been added or edited under a specified directory,
# including the targets of any symlinks.

set -e

if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
    echo "The number of arguments must be either 2 or 3."
    echo "Usage: ./list-targets.sh [path] [commit-before] <[commit-after]>"
    exit 1
fi

# Differences in targets of symbolic links.
symlinks=$(find "$1" -type l)
for l in ${symlinks}; do
  linktarget=$(readlink -f "${l}")
  git diff --name-only "$2" "$3" "$(realpath --relative-to=. "${linktarget}")"
done
