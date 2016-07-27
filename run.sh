#!/bin/bash

export BASEDIR="/opt/ranchertest"
export USER_GROUP="ranchertest:ranchertest"

create_user{
    useradd -m -d /opt/ranchertest ranchertest
    cd /opt/ranchertest && mkdir .ssh && chmod 700 .ssh && chown -R ranchertest:ranchertest .ssh
    sudo adduser ranchertest sudo
    echo "ranchertest ALL=NOPASSWD: ALL">>/etc/sudoers
}

set_authorized_keys()
{
    echo ${SSH_KEY} >> ${BASEDIR}/.ssh/authorized_keys
    chmod 600 ${BASEDIR}/.ssh/authorized_keys
}

create_user
echo ${SSH_KEY}
set_authorized_keys
chown -R ${USER_GROUP} ${BASEDIR}

/usr/sbin/sshd -D
