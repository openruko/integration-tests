print "slotbox run ls ~/"
expect <<EOF
  set timeout 3 
  spawn slotbox run cat Procfile --app slotbox-nodejs-hello-world
  expect "attached to terminal... up, run.1"
  expect "web: node index.js"
  expect eof
EOF

print "slotbox run 'env'"
expect <<EOF
  set timeout 3 
  spawn slotbox run 'env' --app slotbox-nodejs-hello-world
  expect "KEY1=VALUE2"
  expect eof
EOF
