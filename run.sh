# fail fast
set -e

cd tests
./10-restart.sh && ./20-login.sh && ./25-create-app.sh && ./30-push.sh && ./40-update.sh && ./50-scale.sh
