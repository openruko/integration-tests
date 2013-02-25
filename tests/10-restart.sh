sudo stop openruko || true
sudo pkill node || true
sleep 3
dropdb openruko
createdb openruko
sudo start openruko
sudo restart openruko-dynohost HEARTBEAT_INTERVAL=1000

sleep 10
echo -e "test\ntest@test.com\ntest" | ~/openruko/apiserver/apiserver/bin/adduser
