#!/bin/bash -ex

echo "Run SSHD"
/etc/init.d/sshd start

/docker-scripts/create-user.sh

echo "Run command : $@"
exec "$@"