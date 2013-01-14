#!/bin/bash

# fail fast
set -e

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

working_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for i in $working_dir/tests/*; do source "$i"; done
