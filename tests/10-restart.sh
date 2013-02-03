cd ~/openruko/apiserver/postgres
sudo stop openruko
sudo pkill node
echo -e "openruko\ntest\ntest@test.com\ntest" | ./setup
sudo start openruko
sleep 5
