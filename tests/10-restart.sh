sudo stop openruko || true
sudo pkill node || true
dropdb openruko
createdb openruko
sudo start openruko
sleep 10
echo -e "test\ntest@test.com\ntest" | ~/openruko/apiserver/apiserver/bin/adduser
