# Integration tests

It will create a new database, a new node.js project and will push it on [openruko](https://github.com/openruko).

Several openruko commands are tested like:

```
openruko login
openruko logout
openruko create
git push heroku master
openruko releases
openruko ps
openruko logs
...
```

Take a look at the tests

## Install

keepgreen depends on expect
```
sudo apt-get install expect
```

## Run

```
./run.sh
```

Path to `apiserver/postgres/setup` is hardcoded in `10-restart.sh`.

The easier way to launch keengreen tests is by using [vagrant-openruko](https://github.com/Marsup/vagrant-openruko)

## Debug

```
tail -f /var/log/openruko/* &
cd tests
./10-restart.sh
./20-login.sh 
./25-create-app.sh
./30-push.sh 
./40-update.sh 
./50-scale.sh

```
