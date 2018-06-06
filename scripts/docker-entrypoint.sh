#!/bin/bash -ex

echo "Run SSHD"
if [ -f /etc/init.d/sshd ]; then
   /etc/init.d/sshd start
else
   /usr/sbin/sshd -e
fi

/docker-scripts/create-user.sh

echo "Run command : $@"
exec "$@"
