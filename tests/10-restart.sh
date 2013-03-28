# Stop services
sudo stop openruko-apiserver || true

# We might be in a cluster environment where dynohosts are on separate servers
if [[ -f /etc/init/openruko-dynohost.conf ]]; then
  sudo stop openruko-dynohost || true
fi

sudo pkill node || true

sleep 3

# Reset database
dropdb openruko
createdb openruko

# Start services
sudo start openruko-apiserver

# We might be in a cluster environment where dynohosts are on separate servers
if [[ -f /etc/init/openruko-dynohost.conf ]]; then
  # But if we are on the same server as the API then we're probably developing or testing,
  # so shorten the heartbeat for convenience.
  sudo start openruko-dynohost HEARTBEAT_INTERVAL=1000
fi

# Remove slugs and repos
sudo rm -rf /tmp/fakes3_root/openruko

sleep 10

echo -e "test\ntest@test.com\ntest" | ~/openruko/apiserver/apiserver/bin/adduser
