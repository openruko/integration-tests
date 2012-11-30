# force exit on error
set -e

export PATH=$PATH:/home/vagrant/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}


print "list keys (should have one)"
expect << eof
  spawn openruko keys
  expect "=== openruko@openruko.com Keys"
  expect "ssh-rsa"
  expect "..."
  expect "vagrant@precise64"
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
  expect "Uploading SSH public key /home/vagrant/.ssh/id_rsa.pub..."
  expect eof
eof

print "list keys (should have one)"
expect << eof
  spawn openruko keys
  expect "=== openruko@openruko.com Keys"
  expect "ssh-rsa"
  expect "..."
  expect "vagrant@precise64"
  expect eof
eof


print "keys:remove"
expect << eof
  spawn openruko keys:remove vagrant@precise64
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
  expect "Uploading SSH public key /home/vagrant/.ssh/id_rsa.pub..."
  expect eof
eof
