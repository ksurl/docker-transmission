# Docker image for [Transmission](https://transmissionbt.com)

[![](https://img.shields.io/badge/Docker%20Hub--blue)](https://hub.docker.com/r/ksurl/transmission) [![](https://img.shields.io/badge/GitHub%20Container%20Registry--yellow)](https://github.com/users/ksurl/packages/container/package/transmission)

[![](https://img.shields.io/github/v/tag/ksurl/docker-transmission?label=image%20version&logo=docker)](https://hub.docker.com/r/ksurl/transmission) [![](https://img.shields.io/docker/image-size/ksurl/transmission/latest?color=lightgrey&logo=Docker)]() [![](https://img.shields.io/github/workflow/status/ksurl/docker-transmission/build?label=build&logo=Docker)](https://github.com/ksurl/docker-transmission/actions?query=workflow%3Abuild)

* Based on ghcr.io/ksurl/baseimage-alpine
* Web ui: Default, Combustion, or Kettu

# Usage

## docker cli

    docker run -d \
        --name=CONTAINER_NAME \
        -v HOST_DOWNLOADS:/downloads \
        -v HOST_CONFIG:/config \
        -e PUID=1000 \
        -e PGID=1000 \
        -e TRANSMISSION_DOWNLOAD_DIR=/downloads/complete \
        -e TRANSMISSION_INCOMPLETE_DIR=/downloads/incomplete \
        -e TRANSMISSION_WATCH_DIR=/watch \
        -e TRANSMISSION_WEB_UI=combustion \
        -e TRANSMISSION_USER=<USERNAME> \
        -e TRANSMISSION_PASSWORD=<PASSWORD> \
        -e TZ=UTC \
        -p 9091:9091 \
        -p 51413:51413 \
        ghcr.io/ksurl/transmission

## docker-compose 

    version: "3.8"
    services:
      transmission:
        image: ghcr.io/ksurl/transmission
        container_name: transmission
        environment:
          - PUID=1000
          - PGID=1000
          - TRANSMISSION_DOWNLOAD_DIR=/downloads/complete
          - TRANSMISSION_INCOMPLETED_DIR=/downloads/incomplete
          - TRANSMISSION_WATCH_DIR=/watch # optional
          - TRANSMISSION_WEB_UI=<CUSTOM> # optional
          - TRANSMISSION_USER=<USERNAME> # optional
          - TRANSMISSION_PASSWORD=<PASSWORD> # optional
          - TZ=UTC
        ports:
          - 9091:9091
          - 51413:51413
        volumes:
          - <HOST>/config:/config
          - <HOST_MNT>/downloads:/downloads
        restart: unless-stopped

## Parameters

| Parameter | Function | Default |
| :----: | --- | --- |
| `-e PUID` | Set uid | `1000` |
| `-e PGID` | Set gid | `1000` |
| `-e TRANSMISSION_DOWNLOAD_DIR` | Set download folder | `/downloads/complete`|
| `-e TRANSMISSION_INCOMPLETE_DIR` | Set incomplete download folder | `/downloads/incomplete` |
| `-e TRANSMISSION_WATCH_DIR` | Set watch folder. Disabled by default | |
| `-e TRANSMISSION_WEB_UI` | Set web ui. Valid options: `combustion`, `kettu` | |
| `-e TRANSMISSION_USER` | Set transmission username. Authentication is off by default. Only enabled if user and password are both set. | |
| `-e TRANSMISSION_PASSWORD` | Set transmission password. | |
| `-e TZ` | Specify a timezone to use | `UTC` |
| `-p 9091:9091` | Set management port. | `9091` |
| `-p 51413:51413` | Set listening port. | `51413` |
| `-v /config` | Config folder goes here | |
| `-v /downloads` | Downloads go here | |
