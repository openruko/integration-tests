TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR/nodejs-hello-world

print "slotbox deploy"

# Travis CI is currently only 32 bit, so we need to use 32 bit node binaries for now.
# TODO: Remove when Travis CI goes 64 bit.
if [[ "$TRAVIS" = "true" ]]; then
  slotbox config:add BUILDPACK_URL=git://github.com/slotbox/heroku-buildpack-nodejs.git
fi

slotbox deploy

print "wait 15s"
sleep 15

print "curl on slotbox-nodejs-hello-world.slotbox.local"
expect <<EOF
  spawn curl slotbox-nodejs-hello-world.slotbox.local
  expect "Hello World :)"
  expect eof
EOF

print "list apps"
expect <<EOF
  spawn slotbox apps
  expect "slotbox-nodejs-hello-world"
  expect eof
EOF

print "list releases"
expect <<EOF
  spawn slotbox releases --app slotbox-nodejs-hello-world
  expect "v1"
  expect eof
EOF

print "ps"
expect <<EOF
  spawn slotbox ps --app slotbox-nodejs-hello-world
  expect "=== web: \`node index.js\`"
  expect "web.1: running"
  expect eof
EOF

print "logs"
expect <<EOF
  spawn slotbox logs --app slotbox-nodejs-hello-world
  expect "Starting process with command \`node index.js"
  expect "Listening on port"
  expect eof
EOF

print "heartbeats"
heartbeats=$(psql -t openruko -c "SELECT heartbeats FROM openruko_data.app WHERE name='slotbox-nodejs-hello-world';")
print "$heartbeats heartbeats registered"
if [[ "$heartbeats" -lt 2 ]]; then
  print "Heartbeats not working."
  print "This could simply be because the heartbeat interval is too long."
  print "If you're testing Openruko on a cluster with dynos running on separate servers"
  print "then simply restart dynohost with \`sudo restart openruko-dynohost HEARTBEAT_INTERVAL=1000'"
  exit 1
fi