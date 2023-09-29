FROM docker.io/alpine:3.18.4

# https://www.borgbackup.org/releases/
# https://git.alpinelinux.org/aports/log/community/borgbackup?h=3.18-stable
ARG BORGBACKUP_PACKAGE_VERSION=1.2.6-r0
ARG NETCAT_OPENBSD_PACKAGE_VERSION=1.219-r1
# https://www.openssh.com/releasenotes.html
# https://git.alpinelinux.org/aports/log/main/openssh?h=3.18-stable
ARG OPENSSH_CLIENT_PACKAGE_VERSION=9.3_p2-r0
ARG SSHFS_PACKAGE_VERSION=3.7.3-r1
ARG TINI_PACKAGE_VERSION=0.19.0-r1
ARG USER=borg
ARG HOME=/home/borg
RUN apk add --no-cache \
        borgbackup="$BORGBACKUP_PACKAGE_VERSION" \
        netcat-openbsd=$NETCAT_OPENBSD_PACKAGE_VERSION \
        openssh-client="$OPENSSH_CLIENT_PACKAGE_VERSION" \
        sshfs=$SSHFS_PACKAGE_VERSION \
        tini=$TINI_PACKAGE_VERSION \
    && nc -h 2>&1 | grep '"5" (SOCKS)' \
    && adduser -S -h $HOME $USER
VOLUME $HOME

COPY ssh_config /etc/ssh/ssh_config

COPY entrypoint.sh /
ENV SHOW_COMMAND=
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

USER $USER
CMD ["borg", "--help"]

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="alpine image providing borgbackup & openssh client" \
    org.opencontainers.image.source="https://github.com/fphammerle/docker-borgbackup-client" \
    org.opencontainers.image.revision="$REVISION"
