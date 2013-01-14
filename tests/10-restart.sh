cd ~/openruko/apiserver/postgres

if [[ "$(sudo status openruko)" = "openruko start/running" ]]; then
  sudo stop openruko
fi

if [[ "$(pgrep node)" != "" ]]; then
  sudo pkill node
fi

# (Re)initialise
echo -e "openruko\ntest\ntest@test.com\ntest" | ./setup

# Remove slugs and repos
rm -rf /tmp/fakes3_root/openruko

sudo start openruko

sleep 5