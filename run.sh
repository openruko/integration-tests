#!/bin/bash

# fail fast
set -e

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

export PATH=$PATH:~/openruko/client/

working_dir=$(pwd)

for i in tests/*; do source $working_dir/"$i"; done
