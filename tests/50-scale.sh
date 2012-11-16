# force exit on error
set -e

openruko ps:scale web=2

openruko ps
#TODO check ps

openruko logs |grep Scale
# TODO check logs
