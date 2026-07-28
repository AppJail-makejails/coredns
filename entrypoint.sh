#!/bin/sh

. /lib.subr

set -e

if [ "${1#-}" != "$1" ]; then
    set -- coredns "$@"
fi

if [ "$1" = "coredns" ]; then
    create_user

    set -- su-exec noroot "$@"
fi

exec "$@"
