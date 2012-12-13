# force exit on error
set -e

export PATH=$PATH:/home/vagrant/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

print "ps:scale web=5"
expect <<EOF
  spawn openruko ps:scale web=5 --app keepgreen
  expect "Scaling web processes... done"
  expect eof
EOF

print "ps"
expect <<EOF
  spawn openruko ps --app keepgreen
  expect "=== web: \`node server.js\`"
  expect "web.1: "
  expect "web.2: "
  expect "web.3: "
  expect "web.4: "
  expect "web.5: "
  expect eof
EOF

print "ps:scale web=0"
expect <<EOF
  spawn openruko ps:scale web=0 --app keepgreen
  expect "Scaling web processes... done"
  expect eof
EOF

sleep 1

print "curl the old dyno(should not respond)"
expect <<EOF
  spawn curl keepgreen.mymachine.me:8080/hello.txt
  expect "Not found"
  expect eof
EOF

print "check in the logs"
expect <<EOF
  spawn openruko logs --app keepgreen
  expect "Scale"
  expect eof
EOF
