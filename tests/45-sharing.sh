# force exit on error
set -e


export PATH=$PATH:/home/vagrant/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

TEST_DIR=/tmp/openruko-tests2
rm -fr $TEST_DIR || /bin/true
mkdir $TEST_DIR
cd $TEST_DIR
git init


print "list sharings (should print openruko@openruko.com)"
expect <<EOF
  spawn openruko sharing --app keepgreen
  expect "openruko@openruko.com"
  expect eof
EOF


print "sharing:add with invalid email (should fail)"
expect <<EOF
  spawn openruko sharing:add boooo@email.com --app keepgreen
  expect "No user with such email"
  expect eof
EOF

print "add user friend@email.com"
psql openruko -o /dev/null -nq -c "SET search_path TO openruko_data,public; SELECT * FROM openruko_api.add_user('friend@email.com','friend','friend')" && echo "user added"
psql openruko -o /dev/null -nq -c "SET search_path TO openruko_data,public; SELECT * FROM openruko_api.add_key(3,'ssh-rsa','aaabbb','test','aaaaaaa')" && echo "key added"

print "login as friend"
openruko logout
expect << eof
  set timeout 3
  spawn openruko login
  expect "Email"
  send -- "friend@email.com\r"
  expect "Password"
  send -- "friend\r"
  expect "Authentication successful."
  expect eof
eof

print "list apps (should be empty)"
expect <<EOF
  spawn openruko apps
  expect "You have no apps"
  expect eof
EOF

print "login as openruko"
openruko logout
expect << eof
  set timeout 3
  spawn openruko login
  expect "Email"
  send -- "openruko@openruko.com\r"
  expect "Password"
  send -- "vagrant\r"
  expect "Authentication successful."
  expect eof
eof

print "sharing:add friend@emai.com"
expect <<EOF
  spawn openruko sharing:add friend@email.com --app keepgreen
  expect "Adding friend@email.com to keepgreen collaborators... done"
  expect eof
EOF

print "list sharings (should print friend@email.com)"
expect <<EOF
  spawn openruko sharing --app keepgreen
  expect "friend@email.com"
  expect eof
EOF

print "sharing:remove friend@emai.com"
expect <<EOF
  spawn openruko sharing:remove friend@email.com --app keepgreen
  expect "Removing friend@email.com from keepgreen collaborators..."
  expect eof
EOF

print "remove twice to see if it still exists"
expect <<EOF
  spawn openruko sharing:remove friend@email.com --app keepgreen
  expect "not found"
  expect eof
EOF

print "sharing:add friend@emai.com"
expect <<EOF
  spawn openruko sharing:add friend@email.com --app keepgreen
  expect "Adding friend@email.com to keepgreen collaborators... done"
  expect eof
EOF

print "login as friend"
openruko logout
expect << eof
  set timeout 3
  spawn openruko login
  expect "Email"
  send -- "friend@email.com\r"
  expect "Password"
  send -- "friend\r"
  expect "Authentication successful."
  expect eof
eof

print "list apps (should contain keepgreen)"
expect <<EOF
  spawn openruko apps
  expect "=== Collaborated Apps"
  expect "keepgreen"
  expect eof
EOF

# print "create an app"
# expect <<EOF
#   spawn openruko create friendApp
#   expect "Git remote heroku added"
#   expect eof
# EOF

# print "sharing:transfer openruko@openruko.com"
# expect <<EOF
#   spawn openruko sharing:transfer openruko@openruko.com --app keepgreen
#   expect "Adding friend@email.com to keepgreen collaborators... done"
#   expect eof
# EOF

print "login as openruko"
openruko logout
expect << eof
  set timeout 3
  spawn openruko login
  expect "Email"
  send -- "openruko@openruko.com\r"
  expect "Password"
  send -- "vagrant\r"
  expect "Authentication successful."
  expect eof
eof

# print "list apps (should contain friendApp)"
# expect <<EOF
#   spawn openruko apps
#   expect "friendApp"
#   expect eof
# EOF

# print "destroy friendApp"
# expect <<EOF
#   spawn openruko destroy friendApp
#   expect "balbal"
#   expect eof
# EOF
