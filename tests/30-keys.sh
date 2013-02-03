ssh_id=$(cat /home/$KG_USER/.ssh/id_rsa.pub | awk '{ print $(NF) }')

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
  expect "Uploading SSH public key /home/$KG_USER/.ssh/id_rsa.pub..."
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
  expect "Uploading SSH public key /home/$KG_USER/.ssh/id_rsa.pub..."
  expect eof
eof
