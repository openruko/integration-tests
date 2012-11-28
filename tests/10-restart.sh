cd ~/openruko/apiserver/postgres
sudo stop openruko
sudo pkill node
echo -e "openruko\nvagrant\nopenruko@openruko.com\nvagrant" | ./setup
sudo start openruko
