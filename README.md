# Integration tests

It will create a new database, a new node.js project and will push it on [openruko](https://github.com/openruko).

Several openruko commands are tested like:

```
openruko login
openruko logout
openruko create
git push heroku master
openruko releases
openruko config
openruko domains
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
./30-keys.sh
./40-apps.sh
./50-config.sh
./60-push.sh
./70-domains.sh
./80-update.sh
./90-scale.sh

```
