#!/bin/bash -ex

id ${SSH_USER} || useradd -s /bin/bash -m -d /home/${SSH_USER} ${SSH_USER}

echo -ne "Defaults:${SSH_USER} !requiretty\n${SSH_USER} ALL = (ALL) NOPASSWD: ALL\n" > /etc/sudoers.d/${SSH_USER}

mkdir -vp /home/${SSH_USER}/.ssh

cat /docker-scripts/authorized_keys > /home/${SSH_USER}/.ssh/authorized_keys
cat /docker-scripts/id_rsa_insecure > /home/${SSH_USER}/.ssh/id_rsa

chmod 700 /home/${SSH_USER}/.ssh
chmod 600 /home/${SSH_USER}/.ssh/*

chown -vR ${SSH_USER}:${SSH_USER} /home/${SSH_USER}
