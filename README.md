# Redsocks Docker image

[![Image size](https://img.shields.io/docker/image-size/vandreykiv/redsocks/latest.svg)](https://hub.docker.com/r/vandreykiv/redsocks/)
[![Docker pulls](https://img.shields.io/docker/pulls/vandreykiv/redsocks.svg)](https://hub.docker.com/r/vandreykiv/redsocks/)

## Description

This docker image allows you to use docker on a host without being bored by your corporate proxy.

You have just to run this container and all your other containers will be able to access directly to internet (without any proxy configuration).

## Usage

Start the container like this:

```
docker run --privileged=true --net=host -d vandreykiv/redsocks 1.2.3.4 3128
```

Replace the IP and the port by those of your proxy.

The container will start redsocks and automatically configure iptable to forward **all** the TCP traffic through the proxy.

Use docker stop to halt the container. The iptables rules should be reversed. If not, you can execute this command:

```
iptables-save | grep -v REDSOCKS | iptables-restore
```

To run it in K8s you can add additional container to your pod that will forward all traffic to proxy via proxysocks. Example can be found in `examples` directory.

## Build
Build the image with `docker build -t <tag> .`.