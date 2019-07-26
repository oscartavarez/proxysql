FROM debian:stretch
MAINTAINER Oscar Tavarez <otavarez@cloudgeex.com>

ENV VERSION 2.0.5

RUN apt-get update && \
    apt-get install -y wget mysql-client inotify-tools procps nginx vim curl  && \
    wget https://github.com/sysown/proxysql/releases/download/v${VERSION}/proxysql_${VERSION}-debian9_amd64.deb -O /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    dpkg -i /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    rm -f /opt/proxysql_${VERSION}-debian9_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

COPY ./etc /

VOLUME /var/lib/proxysql
EXPOSE 6032 6033 6080 80

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
