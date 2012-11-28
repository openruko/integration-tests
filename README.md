# Integration tests

It will create a new database, a new node.js project and will push it on openruko.

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
tests/restart
```

Path to `apiserver/postgres/setup` is hardcoded in `10-restart.sh`.

The easier way to launch keengreen tests is by using [vagrant-openruko](https://github.com/Marsup/vagrant-openruko)
