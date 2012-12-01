# force exit on error
set -e

export PATH=$PATH:/home/vagrant/openruko/client/

function print {
  echo -e "\n\e[1;36m$1\e[00m"
}


print "list config (should be empty)"
expect << eof
  spawn openruko config --app keepgreen
  expect "keepgreen has no config vars."
  expect eof
eof

print "add a config key"
# TODO check restart
expect << eof
  spawn openruko config:set KEY1=VALUE --app keepgreen
  expect "Setting config vars and restarting keepgreen..."
  expect eof
eof

expect << eof
  spawn openruko releases --app keepgreen
  expect "Add KEY1"
  expect eof
eof

print "list config (should have KEY1)"
expect << eof
  spawn openruko config --app keepgreen
  expect "=== keepgreen Config Vars"
  expect "KEY1: VALUE"
  expect eof
eof

print "get config KEY1"
expect << eof
  spawn openruko config:get KEY1 --app keepgreen
  expect "VALUE"
  expect eof
eof

print "remove config KEY1"
expect << eof
  spawn openruko config:unset KEY1 --app keepgreen
  expect "Unsetting KEY1 and restarting keepgreen..."
  expect eof
eof

expect << eof
  spawn openruko releases --app keepgreen
  expect "Remove KEY1"
  expect eof
eof

print "list config (should be empty)"
expect << eof
  spawn openruko config --app keepgreen
  expect "keepgreen has no config vars."
  expect eof
eof

# Add a key to later check this KEY is accessible inisde a dyno
openruko config:set KEY1=VALUE2 --app keepgreen
