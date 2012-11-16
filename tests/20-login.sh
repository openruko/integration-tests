# force exit on error
set -e

openruko logout
expect << EOF
  spawn openruko login
  expect "Email"
  send "email@company.com\r"
  expect "Password"
  send "password\r"
  interact
EOF

openruko destroy keepgreen

expect <<EOF
  spawn openruko apps
EOF
# TODO should return 0 apps
