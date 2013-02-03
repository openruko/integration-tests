#!/bin/bash

# fail fast
set -e

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

case "$OPENRUKO_ENV" in
  vagrant)
    KG_USER="vagrant"
    KG_GROUP="vagrant"
    KG_PASS="vagrant"
  ;;
  *)
    KG_USER="rukosan"
    KG_GROUP="rukosan"
    KG_PASS="rukosan"
  ;;
esac

export PATH=$PATH:/home/$KG_USER/openruko/client/

working_dir=$(pwd)

for i in tests/*; do source $working_dir/"$i"; done
