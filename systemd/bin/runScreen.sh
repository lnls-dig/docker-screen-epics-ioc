#!/usr/bin/env bash

set -u

if [ -z "$SCREEN_INSTANCE" ]; then
    echo "SCREEN_INSTANCE environment variable is not set." >&2
    exit 1
fi

export SCREEN_CURRENT_PV_AREA_PREFIX=SCREEN_${SCREEN_INSTANCE}_PV_AREA_PREFIX
export SCREEN_CURRENT_PV_DEVICE_PREFIX=SCREEN_${SCREEN_INSTANCE}_PV_DEVICE_PREFIX
export SCREEN_CURRENT_MTR_CTRL_PREFIX=SCREEN_${SCREEN_INSTANCE}_MTR_CTRL_PREFIX
export SCREEN_CURRENT_CAM_PREFIX=SCREEN_${SCREEN_INSTANCE}_CAM_PREFIX
# Only works with bash
export SCREEN_PV_AREA_PREFIX=${!SCREEN_CURRENT_PV_AREA_PREFIX}
export SCREEN_PV_DEVICE_PREFIX=${!SCREEN_CURRENT_PV_DEVICE_PREFIX}
export SCREEN_MTR_CTRL_PREFIX=${!SCREEN_CURRENT_MTR_CTRL_PREFIX}
export SCREEN_CAM_PREFIX=${!SCREEN_CURRENT_CAM_PREFIX}

# Create volume for autosave and ignore errors
/usr/bin/docker create \
    -v /opt/epics/startup/ioc/screen-epics-ioc/iocBoot/iocScreen/autosave \
    --name screen-epics-ioc-${SCREEN_INSTANCE}-volume \
    lnlsdig/screen-epics-ioc:${IMAGE_VERSION} \
    2>/dev/null || true

# Remove a possible old and stopped container with
# the same name
/usr/bin/docker rm \
    screen-epics-ioc-${SCREEN_INSTANCE} || true

/usr/bin/docker run \
    --net host \
    -t \
    --rm \
    --volumes-from screen-epics-ioc-${SCREEN_INSTANCE}-volume \
    --name screen-epics-ioc-${SCREEN_INSTANCE} \
    lnlsdig/screen-epics-ioc:${IMAGE_VERSION} \
    -m "${SCREEN_MTR_CTRL_PREFIX}" \
    -c "${SCREEN_CAM_PREFIX}" \
    -P "${SCREEN_PV_AREA_PREFIX}" \
    -R "${SCREEN_PV_DEVICE_PREFIX}"
