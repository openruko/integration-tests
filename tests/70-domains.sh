print "list domains. (should be empty)"
expect <<EOF
  spawn slotbox domains --app slotbox-nodejs-hello-world
  expect "slotbox-nodejs-hello-world has no domain names."
  expect eof
EOF

print "add domain toto.com"
expect <<EOF
  spawn slotbox domains:add toto.com --app slotbox-nodejs-hello-world
  expect "Adding toto.com to slotbox-nodejs-hello-world... done"
  expect eof
EOF

print "list domains. (should find toto.com)"
expect <<EOF
  spawn slotbox domains --app slotbox-nodejs-hello-world
  expect "=== slotbox-nodejs-hello-world Domain Names"
  expect "toto.com"
  expect eof
EOF

print "remove domain toto.com"
expect <<EOF
  spawn slotbox domains:remove toto.com --app slotbox-nodejs-hello-world
  expect "Removing toto.com from slotbox-nodejs-hello-world... done"
  expect eof
EOF

print "list domains. (should be empty)"
expect <<EOF
  spawn slotbox domains --app slotbox-nodejs-hello-world
  expect "slotbox-nodejs-hello-world has no domain names."
  expect eof
EOF
