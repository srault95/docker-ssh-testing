FROM centos:7

ENV LANG en_US.UTF-8
ENV SSH_USER admin-user

RUN yum install -y git sudo rsync \
    && yum install -y python \
    && yum install -y openssh-server openssh-clients \
    && /usr/sbin/sshd-keygen \
    && yum clean all -y

ENV TESTING 1

ADD scripts /docker-scripts/

ENTRYPOINT ["/docker-scripts/docker-entrypoint.sh"]

CMD tail -F /var/log/yum.log
