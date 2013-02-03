print "change sources"
TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR

sed -i 's/Hello World/Hello World 2/g' server.js
sed -i 's/1337/1338/g' server.js

git commit -am "second commit"

print "git push heroku master"
git push heroku master

print "wait 15s"
sleep 15

print "curl on keepgreen.mymachine.me:8080/hello.txt"
expect <<EOF
  spawn curl keepgreen.mymachine.me:8080/hello.txt
  expect "Hello World 2"
  expect eof
EOF

print "list releases"
expect <<EOF
  spawn openruko releases --app keepgreen
  expect "v3"
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
