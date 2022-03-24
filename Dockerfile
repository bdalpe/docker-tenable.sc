FROM centos:7

VOLUME /opt/sc

ENV SC_VER=5.20.1-el7
ARG S6_OVERLAY_VERSION=3.1.0.1

WORKDIR /tmp

COPY Tenable.repo /etc/yum.repos.d/Tenable.repo

RUN sed -i.backup 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf \
 && yum -y update \
 && rpm --import https://static.tenable.com/marketing/RPM-GPG-KEY-Tenable \
 && yum install -y wget java-1.8.0-openjdk xz-utils \
 && yum -y clean all

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

EXPOSE 443

RUN useradd tns

COPY container-files /

ENTRYPOINT ["/init"]
