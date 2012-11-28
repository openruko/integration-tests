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

print "check with openruko ps"
openruko ps --app keepgreen |grep "web" || echo "OK keepgreen is not present"

print "check with a system ps"
ps auxf | grep "node server.js" |grep -v grep|| echo "OK server is stopped"

print "check in the logs"
expect <<EOF
  spawn openruko logs
  expect "Scale"
  expect eof
EOF
