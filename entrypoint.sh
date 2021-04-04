#!/bin/sh

set -eu

if [ ! -f ~/.ssh/id_ed25519 ]; then
    (set -x; ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519)
    cat ~/.ssh/id_ed25519.pub
fi

set -x

exec "$@"
