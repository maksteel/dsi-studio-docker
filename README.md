[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/manishka/dsi-studio-docker)](https://hub.docker.com/r/manishka/dsi-studio-docker/builds)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/manishka/dsi-studio-docker)](https://hub.docker.com/r/manishka/dsi-studio-docker/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/manishka/dsi-studio-docker)](https://hub.docker.com/r/manishka/dsi-studio-docker)

# dsi-studio-docker

[DSI Studio](http://dsi-studio.labsolver.org/) in a Docker container.

## Requirements

* Docker 
* An X11 socket

## Quickstart

Assuming  that you are able to run `docker`
commands [without `sudo`](http://docs.docker.io/installation/ubuntulinux/#giving-non-root-access),
run below command from the directory (`$PWD`) which stores the datasets or images.
In the (dockerized) DSI Studio, these datasets or images can be browsed under `/data` directory.

```
docker run -ti --rm -e DISPLAY=$DISPLAY \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v $PWD:/data \
                    manishka/dsi-studio-docker:latest 
```

## Help! I started the container but I don't see the DSI Studio screen

You might have an issue with the X11 socket permissions since the default user
used by the base image has an user and group ids set to `1000`, in that case
you can run either create your own base image with the appropriate ids or run below command on your machine and try again.
```
xhost +
``` 

### over SSH with X11Forwarding
If you are running docker remotely with ssh and see the error
> qt.qpa.xcb: could not connect to display localhost:64.0
> qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
> This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.
>
> Available platform plugins are: linuxfb, minimal, offscreen, vnc, xcb.

you may need additional docker parameters `--net host  -v $HOME/.Xauthority:/root/.Xauthority:rw`

```
docker run -ti --rm -e DISPLAY=$DISPLAY \
                    --net host  -v $HOME/.Xauthority:/root/.Xauthority:rw \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v $PWD:/data \
                    manishka/dsi-studio-docker:latest 
```

