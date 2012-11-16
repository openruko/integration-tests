cd ~
git clone https://github.com/openruko/gitmouth.git gitmouth
cd gitmouth
virtualenv --no-site-packages .

make init
make certs

./debug.launch &
