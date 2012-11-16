# force exit on error
set -e

TEST_DIR=/tmp/openruko-tests
rm -fr $TEST_DIR
mkdir $TEST_DIR
cd $TEST_DIR

cat >> package.json <<EOF
{
  "name": "hello-world",
  "description": "hello world test app",
  "version": "0.0.1",
  "private": true,
  "dependencies": {
    "express": "3.x"
  }
}
EOF

cat >> server.js <<EOF
  var express = require('express');
  var app = express();
  app.get('/hello.txt', function(req, res){
    res.send('Hello World');
  });
  var port = process.env.PORT;
  app.listen(port);
  console.log('Listening on port ' + port);
EOF

cat >> Procfile << EOF
web: node server.js
EOF

git init
git add -A
git commit -m "first commit"

openruko create keepgreen

# TODO patch or make a Pull Request on heroku client to remove this sed
sed -i 's/git\@mymachine\.me/ssh\:\/\/mymachine\.com\:2222/g' .git/config

git push heroku master

content=$(curl keepgreen.mymachine.me)
if [ "$content" -ne "Hello World" ]; then
  echo "Bad response text from keepgreen.mymachine.me"
  echo $content
  exit -1;
else

content=$(openruko apps)
if [[ "$content" -ne *"keepGreen"* ]]
then
  echo "heroku apps does not contains our application."
  exit -1;
fi

openruko realeases
#TODO check releases

openruko ps
#TODO check ps

openruko logs
#TODO check listening on port
