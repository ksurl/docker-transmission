# Docker image for [Transmission](https://transmissionbt.com)

* Based on alpine
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
        ksurl/transmission

## docker-compose 

    version: "2"
    services:
      transmission:
        image: ksurl/transmission
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
| `-p 9091:9091 | Set management port. | `9091` |
| `-p 51413:51413` | Set listening port. | `51413` |
| `-v /config` | Config folder goes here | |
| `-v /downloads` | Downloads go here | |
