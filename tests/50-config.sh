print "list config (should be empty)"
expect << eof
  spawn slotbox config --app slotbox-nodejs-hello-world
  expect "slotbox-nodejs-hello-world has no config vars."
  expect eof
eof

print "add a config key"
# TODO check restart
expect << eof
  spawn slotbox config:set KEY1=VALUE --app slotbox-nodejs-hello-world
  expect "Setting config vars and restarting slotbox-nodejs-hello-world..."
  expect eof
eof

expect << eof
  spawn slotbox releases --app slotbox-nodejs-hello-world
  expect "Add KEY1"
  expect eof
eof

print "list config (should have KEY1)"
expect << eof
  spawn slotbox config --app slotbox-nodejs-hello-world
  expect "=== slotbox-nodejs-hello-world Config Vars"
  expect "KEY1: VALUE"
  expect eof
eof

print "get config KEY1"
expect << eof
  spawn slotbox config:get KEY1 --app slotbox-nodejs-hello-world
  expect "VALUE"
  expect eof
eof

print "remove config KEY1"
expect << eof
  spawn slotbox config:unset KEY1 --app slotbox-nodejs-hello-world
  expect "Unsetting KEY1 and restarting slotbox-nodejs-hello-world..."
  expect eof
eof

expect << eof
  spawn slotbox releases --app slotbox-nodejs-hello-world
  expect "Remove KEY1"
  expect eof
eof

print "list config (should be empty)"
expect << eof
  spawn slotbox config --app slotbox-nodejs-hello-world
  expect "slotbox-nodejs-hello-world has no config vars."
  expect eof
eof

# Add a key to later check this KEY is accessible inisde a dyno
slotbox config:set KEY1=VALUE2 --app slotbox-nodejs-hello-world
