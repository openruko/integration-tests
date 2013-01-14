TEST_DIR=/tmp/openruko-tests2
rm -fr $TEST_DIR || /bin/true
mkdir $TEST_DIR
cd $TEST_DIR
git init


print "list sharings (should print test@test.com)"
expect <<EOF
  spawn slotbox sharing --app slotbox-nodejs-hello-world
  expect "test@test.com"
  expect eof
EOF


print "sharing:add with invalid email (should fail)"
expect <<EOF
  spawn slotbox sharing:add boooo@email.com --app slotbox-nodejs-hello-world
  expect "No user with such email"
  expect eof
EOF

print "add user friend@email.com"
psql openruko -o /dev/null -nq -c "SET search_path TO openruko_data,public; SELECT * FROM openruko_api.add_user('friend@email.com','friend','friend')" && echo "user added"
psql openruko -o /dev/null -nq -c "SET search_path TO openruko_data,public; SELECT * FROM openruko_api.add_key(3,'ssh-rsa','aaabbb','test','aaaaaaa')" && echo "key added"

print "login as friend"
slotbox logout
expect << eof
  set timeout 3
  spawn slotbox login
  expect "Email"
  send -- "friend@email.com\r"
  expect "Password"
  send -- "friend\r"
  expect "Authentication successful."
  expect eof
eof

print "list apps (should be empty)"
expect <<EOF
  spawn slotbox apps
  expect "You have no apps"
  expect eof
EOF

print "login as test"
slotbox logout
expect << eof
  set timeout 3
  spawn slotbox login
  expect "Email"
  send -- "test@test.com\r"
  expect "Password"
  send -- "test\r"
  expect "Authentication successful."
  expect eof
eof

print "sharing:add friend@emai.com"
expect <<EOF
  spawn slotbox sharing:add friend@email.com --app slotbox-nodejs-hello-world
  expect "Adding friend@email.com to slotbox-nodejs-hello-world collaborators... done"
  expect eof
EOF

print "list sharings (should print friend@email.com)"
expect <<EOF
  spawn slotbox sharing --app slotbox-nodejs-hello-world
  expect "friend@email.com"
  expect eof
EOF

print "sharing:remove friend@emai.com"
expect <<EOF
  spawn slotbox sharing:remove friend@email.com --app slotbox-nodejs-hello-world
  expect "Removing friend@email.com from slotbox-nodejs-hello-world collaborators..."
  expect eof
EOF

print "remove twice to see if it still exists"
expect <<EOF
  spawn slotbox sharing:remove friend@email.com --app slotbox-nodejs-hello-world
  expect "not found"
  expect eof
EOF

print "sharing:add friend@emai.com"
expect <<EOF
  spawn slotbox sharing:add friend@email.com --app slotbox-nodejs-hello-world
  expect "Adding friend@email.com to slotbox-nodejs-hello-world collaborators... done"
  expect eof
EOF

print "login as friend"
slotbox logout
expect << eof
  set timeout 3
  spawn slotbox login
  expect "Email"
  send -- "friend@email.com\r"
  expect "Password"
  send -- "friend\r"
  expect "Authentication successful."
  expect eof
eof

print "list apps (should contain slotbox-nodejs-hello-world)"
expect <<EOF
  spawn slotbox apps
  expect "=== Collaborated Apps"
  expect "slotbox-nodejs-hello-world"
  expect eof
EOF

# The following tests are commented because transfering apps is not yet implemented

# print "create an app"
# expect <<EOF
#   spawn slotbox create friendApp
#   expect "Git remote heroku added"
#   expect eof
# EOF

# print "sharing:transfer test@test.com"
# expect <<EOF
#   spawn slotbox sharing:transfer test@test.com --app slotbox-nodejs-hello-world
#   expect "Adding friend@email.com to slotbox-nodejs-hello-world collaborators... done"
#   expect eof
# EOF

print "login as test"
slotbox logout
expect << eof
  set timeout 3
  spawn slotbox login
  expect "Email"
  send -- "test@test.com\r"
  expect "Password"
  send -- "test\r"
  expect "Authentication successful."
  expect eof
eof

# print "list apps (should contain friendApp)"
# expect <<EOF
#   spawn slotbox apps
#   expect "friendApp"
#   expect eof
# EOF

# print "destroy friendApp"
# expect <<EOF
#   spawn slotbox destroy friendApp
#   expect "balbal"
#   expect eof
# EOF
