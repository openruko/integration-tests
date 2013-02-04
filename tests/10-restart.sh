sudo stop openruko
sudo pkill node
dropdb openruko
createdb openruko
sudo start openruko
sleep 10
echo -e "test\ntest@test.com\ntest" | ~/openruko/apiserver/apiserver/bin/adduser
