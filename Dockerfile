FROM        ghcr.io/linuxserver/baseimage-alpine:3.12

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-transmission"

LABEL       maintainer="ksurl"

ENV         TRANSMISSION_DOWNLOAD_DIR=/downloads/complete \
            TRANSMISSION_INCOMPLETE_DIR=/downloads/incomplete

RUN         echo "**** install packages ****" && \
            apk add --no-cache \
                transmission-cli \
                transmission-daemon && \
            echo "**** download web ui ****" && \
            mkdir -p /etc/transmission/web && \
            wget -qO- https://github.com/Secretmapper/combustion/archive/release.tar.gz | tar xz -C /etc/transmission/web && \
            wget -qO- https://github.com/endor/kettu/archive/master.tar.gz | tar xz -C /etc/transmission/web && \
            echo "**** cleanup ****" && \
            rm -rf /tmp/* /var/cache/apk/*

COPY        root/ /

HEALTHCHECK --interval=60s --timeout=15s --start-period=5s --retries=3 \
            CMD [ "/bin/ash", "-c", "/bin/netstat -lntp | /bin/grep -q -E '0.0.0.0:9091'" ]

EXPOSE      9091 51413
VOLUME      /config /downloads