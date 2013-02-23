sudo stop openruko || true
sudo pkill node || true
sleep 3
dropdb openruko
createdb openruko
sudo start openruko

# Remove slugs and repos
sudo rm -rf /tmp/fakes3_root/openruko

sleep 10
echo -e "test\ntest@test.com\ntest" | ~/openruko/apiserver/apiserver/bin/adduser
