FROM centos:7

ENV SC_VER=5.9.0-el7
ARG S6_OVERLAY_VERSION=1.21.8.0

WORKDIR /tmp

COPY yum.repo /etc/yum.repos.d/Tenable.repo
COPY gpg.key /etc/pki/rpm-gpg/RPM-GPG-KEY-Tenable

RUN yum install -y wget java-1.8.0-openjdk \
 && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz \
 && tar xzf s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
 && tar xzf s6-overlay-amd64.tar.gz -C /usr ./bin \
 && yum -y clean all 

EXPOSE 443

RUN useradd tns

COPY container-files /

ENTRYPOINT ["/init"]
