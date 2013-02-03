# force exit on error
set -e


export PATH=$PATH:/home/rukosan/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR

# Travis CI is currently only 32 bit, so we need to use 32 bit node binaries for now.
# TODO: Remove when Travis CI goes 64 bit.
if [[ "$TRAVIS" = "true" ]]; then
  openruko config:add BUILDPACK_URL=git://github.com/slotbox/heroku-buildpack-nodejs.git
fi

print "git push heroku master"
rm -f "/home/rukosan/.ssh/known_hosts"
git push heroku master -f

print "wait 15s"
sleep 15

print "curl on keepgreen.mymachine.me:8080/hello.txt"
expect <<EOF
  spawn curl keepgreen.mymachine.me:8080/hello.txt
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
  expect "interval 1s: VALUE2"
  expect eof
EOF
