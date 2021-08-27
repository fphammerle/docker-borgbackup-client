FROM docker.io/alpine:3.14.2

ARG BORGBACKUP_PACKAGE_VERSION=1.1.16-r1
ARG NETCAT_OPENBSD_PACKAGE_VERSION=1.130-r2
ARG OPENSSH_CLIENT_PACKAGE_VERSION=8.6_p1-r2
ARG TINI_PACKAGE_VERSION=0.19.0-r0
ARG USER=borg
ARG HOME=/home/borg
RUN apk add --no-cache \
        borgbackup="$BORGBACKUP_PACKAGE_VERSION" \
        netcat-openbsd=$NETCAT_OPENBSD_PACKAGE_VERSION \
        openssh-client="$OPENSSH_CLIENT_PACKAGE_VERSION" \
        tini=$TINI_PACKAGE_VERSION \
    && nc -h 2>&1 | grep '"5" (SOCKS)' \
    && adduser -S -h $HOME $USER
VOLUME $HOME

COPY entrypoint.sh /
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

USER $USER
CMD ["borg", "--help"]

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="alpine image providing borgbackup & openssh client" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-borgbackup-client" \
    org.opencontainers.image.revision="$REVISION"
