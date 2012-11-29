# force exit on error
set -e


export PATH=$PATH:/home/vagrant/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

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
  "engines": {
    "node": "0.8.x",
    "npm": "1.1.x"
  },
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
  var port = 1337;
  app.listen(port);
  console.log('Listening on port ' + port);
  setInterval(function(){ 
    console.log('interval');
  }, 1000);
EOF

cat >> Procfile << EOF
web: node server.js
EOF

git init
git add -A
git commit -m "first commit"


print "create an app"
expect <<EOF
  spawn openruko create keepgreen
  expect "Git remote heroku added"
  expect eof
EOF

print "git push heroku master"
rm -f "/home/vagrant/.ssh/known_hosts"
git push heroku master -f

print "wait 15s"
sleep 15

print "curl on 127.0.0.1:1337/hello.txt"
expect <<EOF
  spawn curl 127.0.0.1:1337/hello.txt
  expect "Hello World"
  expect eof
EOF

print "list apps"
expect <<EOF
  spawn openruko apps
  expect "keepgreen"
  expect eof
EOF

print "list releases"
expect <<EOF
  spawn openruko releases --app keepgreen
  expect "v2"
  expect "v1"
  expect eof
EOF

print "ps"
expect <<EOF
  spawn openruko ps --app keepgreen
  expect "=== web: \`node server.js\`"
  expect "web.1: running"
  expect eof
EOF

print "logs"
expect <<EOF
  spawn openruko logs --app keepgreen
  expect "Listening on port"
  expect eof
EOF
