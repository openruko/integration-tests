TEST_DIR=/tmp/openruko-tests
cd $TEST_DIR/nodejs-hello-world

print "slotbox deploy"

slotbox deploy

print "wait 10s"
sleep 10

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
