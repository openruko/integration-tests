TEST_DIR=/tmp/openruko-tests
rm -fr $TEST_DIR
mkdir $TEST_DIR
cd $TEST_DIR

git clone git://github.com/slotbox/nodejs-hello-world.git

cd nodejs-hello-world

print "list apps (should be empty)"
expect <<EOF
  spawn slotbox apps
  expect "You have no apps"
  expect eof
EOF

print "create an app"
expect <<EOF
  spawn slotbox create
  expect "nodejs-hello-world.slotbox.local"
  expect eof
EOF

print "list apps (should contain slotbox-nodejs-hello-world)"
expect <<EOF
  spawn slotbox apps
  expect "=== My Apps"
  expect "slotbox-nodejs-hello-world"
  expect eof
EOF

print "destroy app"
slotbox destroy --confirm slotbox-nodejs-hello-world || /bin/true

print "list apps (should be empty)"
expect <<EOF
  spawn slotbox apps
  expect "You have no apps"
  expect eof
EOF

print "destroy app twice, App not found should be printed."
expect << eof
  set timeout 3
  spawn slotbox destroy nodejs-hello-world
  expect "App not found"
  expect eof
eof

print "create an app"
expect <<EOF
  spawn slotbox create
  expect "slotbox-nodejs-hello-world.slotbox.local"
  expect eof
EOF
