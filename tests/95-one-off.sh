print "openruko run ls ~/"
expect <<EOF
  set timeout 3 
  spawn openruko run cat Procfile --app keepgreen
  expect "attached to terminal... up, run.1"
  expect "web: node server.js"
  expect eof
EOF
