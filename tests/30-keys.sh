# force exit on error
set -e

export PATH=$PATH:/home/rukosan/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}

ssh_id=$(cat /home/rukosan/.ssh/id_rsa.pub | awk '{ print $(NF) }')

print "list keys (should have one)"
expect << eof
  spawn openruko keys
  expect "=== openruko@openruko.com Keys"
  expect "ssh-rsa"
  expect "..."
  expect "$ssh_id"
  expect eof
eof

print "keys:clear"
expect << eof
  spawn openruko keys:clear
  expect "done"
  expect eof
eof

print "list keys (should be empty)"
expect << eof
  spawn openruko keys
  expect "You have no keys."
  expect eof
eof

print "add a key"
expect << eof
  spawn openruko keys:add
  expect "Uploading SSH public key /home/rukosan/.ssh/id_rsa.pub..."
  expect eof
eof

print "list keys (should have one)"
expect << eof
  spawn openruko keys
  expect "=== openruko@openruko.com Keys"
  expect "ssh-rsa"
  expect "..."
  expect "$ssh_id"
  expect eof
eof


print "keys:remove"
expect << eof
  spawn openruko keys:remove $ssh_id
  expect "done"
  expect eof
eof

print "list keys (should be empty)"
expect << eof
  spawn openruko keys
  expect "You have no keys."
  expect eof
eof

print "add a key"
expect << eof
  spawn openruko keys:add
  expect "Uploading SSH public key /home/rukosan/.ssh/id_rsa.pub..."
  expect eof
eof
