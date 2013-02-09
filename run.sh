#!/bin/bash

# fail fast
set -e

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

export PATH=$PATH:~/openruko/client/

working_dir=$(pwd)

if [[ "$TRAVIS" = "true" ]]; then
 tail -f /var/log/openruko/* & 
fi

for i in tests/*; do source $working_dir/"$i"; done
