cd ~
git clone https://github.com/openruko/apiserver.git
cd ~/apiserver

make init
make certs

# TODO check this works
createuser -s -U postgres $USER

echo "export API_SERVER_KEY=123" >> ~/.bashrc
echo "export PGUSER=$USER" >> ~/.bashrc
echo "export S3_KEY=123" >> ~/.bashrc
echo "export S3_SECRET=abc" >> ~/.bashrc
echo "export S3_BUCKET=openruko" >> ~/.bashrc

source ~/.bashrc

cd postgres

# TODO add default (from env) values in pgsql setup
./setup --auto

./debug.launch &
