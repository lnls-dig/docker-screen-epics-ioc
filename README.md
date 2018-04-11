Docker image to run the Fluorescent Screen Soft EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[Fluorescent Screen Soft EPICS IOC](https://github.com/lnls-dig/screen-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/screen-epics-ioc -m MTR_CTRL_PREFIX -c CAM_PREFIX

where `MTR_CTRL_PREFIX` is the prefix used for the motor controller
IOC, and `CAM_PREFIX` is the prefix used for the camera IOC.
The options you can specify (after `lnlsdig/screen-epics-ioc`) are:

- `-m MTR_CTRL_PREFIX`: the prefix used for the motion controller IOC (required)
- `-c CAM_PREFIX`: the prefix used for the camera IOC (required)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/screen-epics-ioc -m MTR_CTRL_PREFIX -c CAM_PREFIX

where `MTR_CTRL_PREFIX` and `CAM_PREFIX` are as in the previous section and `CONTAINER_NAME`
is the name given to the container. You can also use the same options as described in the
previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-screen-epics-ioc
    docker build -t lnlsdig/screen-epics-ioc docker-screen-epics-ioc
