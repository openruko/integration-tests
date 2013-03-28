TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR

# Travis CI is currently only 32 bit, so we need to use 32 bit node binaries for now.
# TODO: Remove when Travis CI goes 64 bit.
if [[ "$TRAVIS" = "true" ]]; then
  openruko config:add BUILDPACK_URL=git://github.com/slotbox/heroku-buildpack-nodejs.git
fi

print "git push heroku master"
rm -f "/home/rukosan/.ssh/known_hosts"
git push heroku master -f || true

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

print "heartbeats"
heartbeats=$(psql -t openruko -c "SELECT heartbeats FROM openruko_data.app WHERE name='keepgreen';")
print "$heartbeats heartbeats registered"
if [[ "$heartbeats" -lt 2 ]]; then
  print "Heartbeats not working."
  print "This could simply be because the heartbeat interval is too long."
  print "If you're testing Openruko on a cluster with dynos running on separate servers"
  print "then simply restart dynohost with \`sudo restart openruko-dynohost HEARTBEAT_INTERVAL=1000'"
  exit 1
fi
