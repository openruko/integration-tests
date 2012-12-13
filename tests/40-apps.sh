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
  var port = process.env.PORT;
  app.listen(port);
  console.log('Listening on port ' + port);
  setInterval(function(){
    console.log('interval 1s:', process.env.KEY1);
  }, 1000);
EOF

cat >> Procfile << EOF
web: node server.js
EOF

git init
git add -A
git commit -m "first commit"


print "list apps (should be empty)"
expect <<EOF
  spawn openruko apps
  expect "You have no apps"
  expect eof
EOF

print "create an app"
expect <<EOF
  spawn openruko create keepgreen
  expect "Git remote heroku added"
  expect eof
EOF

print "list apps (should contain keepgreen)"
expect <<EOF
  spawn openruko apps
  expect "=== My Apps"
  expect "keepgreen"
  expect eof
EOF

print "destroy app"
openruko destroy --confirm keepgreen || /bin/true

print "list apps (should be empty)"
expect <<EOF
  spawn openruko apps
  expect "You have no apps"
  expect eof
EOF

print "destroy app twice, App not found should be printed."
expect << eof
  set timeout 3
  spawn openruko destroy keepgreen
  expect "App not found"
  expect eof
eof

print "create an app"
expect <<EOF
  spawn openruko create keepgreen
  expect "Git remote heroku added"
  expect eof
EOF
