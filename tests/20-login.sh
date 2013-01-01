# force exit on error
set -e

export PATH=$PATH:/home/rukosan/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}


print "logout"
openruko logout

print login
expect << eof
  set timeout 3 
  spawn openruko login
  expect "Email"
  send -- "openruko@openruko.com\r"
  expect "Password"
  send -- "rukosan\r"
  expect "Uploading SSH public key /home/rukosan/.ssh/id_rsa.pub."
  expect "Authentication successful."
  expect eof
eof
