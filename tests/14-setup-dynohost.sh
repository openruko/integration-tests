cd ~
git clone https://github.com/openruko/dynohost.git
cd ~/dynohost

mkdir /tmp/or-sockets
echo "export SOCKET_PATH=/tmp/or-sockets" >> ~/.bashrc

make init
make certs

git clone https://github.com/openruko/codonhooks.git
echo "export CODONHOOKS_PATH=$HOME/dynohost/codonhooks" >> ~/.bashrc

git clone https://github.com/openruko/rukorun.git
cd ~/dynohost/rukorun
npm install
echo "export RUKORUN_PATH=$HOME/dynohost/rukorun" >> ~/.bashrc

cd ~/dynohost

source ~/.bashrc

./debug.launch &
