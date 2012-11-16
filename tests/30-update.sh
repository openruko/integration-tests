# force exit on error
set -e

TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR

sed -i 's/Hello World/Hello World 2/g' server.js

git commit -am "second commit"

git push heroku master

if [ $(curl keepgreen.mymachine.me) -ne "Hello World 2" ]; then
  exit -1;
else

openruko realeases
#TODO check releases

openruko logs
#TODO check restart logs
