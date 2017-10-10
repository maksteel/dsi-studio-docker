# dsi-studio-docker

[DSI Studio](http://dsi-studio.labsolver.org/) in a Docker container.

## Requirements

* Docker 
* An X11 socket

## Quickstart

Assuming  that you are able to run `docker`
commands [without `sudo`](http://docs.docker.io/installation/ubuntulinux/#giving-non-root-access),

```
docker run -ti --rm -e DISPLAY=$DISPLAY \
                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                    -v $PWD:/data
                    manishka/dsi-studio-docker:latest 
```

## Help! I started the container but I don't see the DSI Studio screen

You might have an issue with the X11 socket permissions since the default user
used by the base image has an user and group ids set to `1000`, in that case
you can run either create your own base image with the appropriate ids or run
```xhost +``` 
on your machine and try again.


