# BorgBackup Client Container Image 💾 🐳 🐙

Alpine-based image providing
[BorgBackup](https://www.borgbackup.org/)
and [OpenSSH client](https://www.openssh.com/)

```sh
# 1. retrieve and authorize ssh client's public key
$ sudo docker run --name borgbackup_client --rm \
    -v borgbackup_client_home:/home/borg:rw \
    --read-only --security-opt=no-new-privileges --cap-drop=ALL \
    fphammerle/borgbackup-client \
    cat /home/borg/.ssh/id_ed25519.pub

# 2. add ssh server's host key to client's known_hosts file
$ sudo vim "$(sudo docker volume inspect --format '{{.Mountpoint}}' borgbackup_client_home)/.ssh/known_hosts"

# 3. set password for borg repository
$ tr -dc '1-9a-zA-Z' < /dev/random | head -c 64 \
    | sudo tee "$(sudo docker volume inspect --format '{{.Mountpoint}}' borgbackup_client_home)/borg-passphrase"

# 4. initialize borg repository
$ sudo docker run --name borgbackup_client --rm \
    -v borgbackup_client_home:/home/borg:rw \
    --read-only --security-opt=no-new-privileges --cap-drop=ALL \
    --tmpfs /tmp:size=4M \
    -e BORG_PASSCOMMAND="cat /home/borg/borg-passphrase" \
    fphammerle/borgbackup-client \
    borg init --encryption=repokey ssh://username@host//repository

# 5. create snapshot / backup
$ sudo docker run --name borgbackup_client --rm \
    -v borgbackup_client_home:/home/borg:rw \
    -v ~/documents:/data/documents \
    -v ~/photos:/data/photos \
    -v … \
    --tmpfs /tmp:size=4M \
    -e BORG_PASSCOMMAND="cat /home/borg/borg-passphrase" \
    fphammerle/borgbackup-client \
    borg create --stats ssh://username@host//repository::{hostname}-{utcnow} /data
```

`sudo docker` may be replaced with `podman`.

Pre-built docker images are available at https://hub.docker.com/r/fphammerle/borgbackup-client/tags
(mirror: https://quay.io/repository/fphammerle/borgbackup-client?tab=tags)

Annotation of signed git tags `docker/*` contains docker image digests: https://github.com/fphammerle/docker-borgbackup-client/tags

Detached signatures of images are available at https://github.com/fphammerle/container-image-sigstore.
