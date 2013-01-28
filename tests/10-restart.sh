sudo stop openruko
sudo pkill node
dropdb openruko
createdb openruko
sudo start openruko
sleep 5
echo -e "vagrant\nopenruko@openruko.com\nvagrant" | ~/openruko/apiserver/apiserver/bin/adduser
