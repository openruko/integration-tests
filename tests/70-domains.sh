print "list domains. (should be empty)"
expect <<EOF
  spawn openruko domains --app keepgreen
  expect "keepgreen has no domain names."
  expect eof
EOF

print "add domain toto.com"
expect <<EOF
  spawn openruko domains:add toto.com --app keepgreen
  expect "Adding toto.com to keepgreen... done"
  expect eof
EOF

print "list domains. (should find toto.com)"
expect <<EOF
  spawn openruko domains --app keepgreen
  expect "=== keepgreen Domain Names"
  expect "toto.com"
  expect eof
EOF

print "remove domain toto.com"
expect <<EOF
  spawn openruko domains:remove toto.com --app keepgreen
  expect "Removing toto.com from keepgreen... done"
  expect eof
EOF

print "list domains. (should be empty)"
expect <<EOF
  spawn openruko domains --app keepgreen
  expect "keepgreen has no domain names."
  expect eof
EOF
