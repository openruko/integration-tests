cd ~/openruko/apiserver/postgres
sudo stop openruko
sudo pkill node
echo -e "openruko\nrukosan\nopenruko@openruko.com\nrukosan" | ./setup
sudo start openruko
sleep 5
