print "ps:scale web=3"
expect <<EOF
  spawn slotbox ps:scale web=3 --app slotbox-nodejs-hello-world
  expect "Scaling web processes... done"
  expect eof
EOF

print "ps"
expect <<EOF
  spawn slotbox ps --app slotbox-nodejs-hello-world
  expect "=== web: \`node index.js\`"
  expect "web.1: "
  expect "web.2: "
  expect "web.3: "
  expect eof
EOF

print "ps:scale web=0"
expect <<EOF
  spawn slotbox ps:scale web=0 --app slotbox-nodejs-hello-world
  expect "Scaling web processes... done"
  expect eof
EOF

sleep 1

print "curl the old dyno(should not respond)"
expect <<EOF
  spawn curl slotbox-nodejs-hello-world.slotbox.local
  expect "Not found"
  expect eof
EOF

slotbox ps:scale web=1 --app slotbox-nodejs-hello-world

sleep 1