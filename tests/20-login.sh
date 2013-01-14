print "logout"
slotbox logout

print login
expect << eof
  set timeout 3 
  spawn slotbox login
  expect "Email"
  send -- "test@test.com\r"
  expect "Password"
  send -- "test\r"
  expect "Uploading SSH public key"
  expect "Authentication successful."
  expect eof
eof
