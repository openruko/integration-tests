# force exit on error
set -e

export PATH=$PATH:/home/vagrant/openruko/client/

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
  send -- "vagrant\r"
  expect "Uploading SSH public key /home/vagrant/.ssh/id_rsa.pub."
  expect "Authentication successful."
  expect eof
eof

print "destroy app (not found is ok)"
openruko destroy --confirm keepgreen || /bin/true

print "destroy app twice, App not found should be printed."
expect << eof
  set timeout 3 
  spawn openruko destroy keepgreen
  expect "App not found"
  expect eof
eof

