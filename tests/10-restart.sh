cd ~/openruko/apiserver/postgres
sudo stop openruko
sudo pkill node
echo -e "openruko\n$KG_USER\nopenruko@openruko.com\n$KG_PASS" | ./setup
sudo start openruko
sleep 5
