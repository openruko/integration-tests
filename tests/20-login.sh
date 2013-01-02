print "logout"
openruko logout

print login
expect << eof
  set timeout 3 
  spawn openruko login
  expect "Email"
  send -- "openruko@openruko.com\r"
  expect "Password"
  send -- "$KG_PASS\r"
  expect "Uploading SSH public key /home/$KG_USER/.ssh/id_rsa.pub."
  expect "Authentication successful."
  expect eof
eof
