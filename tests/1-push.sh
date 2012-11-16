TEST_DIR=/tmp/openruko-tests
rm -fr $TEST_DIR
mkdir $TEST_DIR
cd $TEST_DIR


cat >> package.json <<EOF
{
  "name": "hello-world",
  "description": "hello world test app",
  "version": "0.0.1",
  "private": true,
  "dependencies": {
    "express": "3.x"
  }
}
EOF

cat >> server.js <<EOF
var express = require('express');
var app = express();
app.get('/hello.txt', function(req, res){
  res.send('Hello World');
});
var port = process.env.PORT;
app.listen(port);
console.log('Listening on port ' + port);
EOF

cat >> Procfile << EOF
web: node server.js
EOF

git init
git add -A
git commit -m "first commit"

openruko create keepgreen

