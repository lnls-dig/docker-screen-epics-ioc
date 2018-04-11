#!/usr/bin/env bash

set -u

if [ -z "$SCREEN_INSTANCE" ]; then
    echo "SCREEN_INSTANCE environment variable is not set." >&2
    exit 1
fi

/usr/bin/docker stop \
    screen-epics-ioc-${SCREEN_INSTANCE}
