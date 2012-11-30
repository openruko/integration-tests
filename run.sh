# fail fast
set -e

for i in tests/*; do bash "$i"; done
