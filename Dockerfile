FROM        alpine

LABEL       org.opencontainers.image.source="https://github.com/ksurl/docker-transmission"

LABEL       maintainer="ksurl"

WORKDIR     /config

VOLUME      /config /downloads

EXPOSE      9091 51413

ENV         PUID=1000 \
            PGID=1000 \
            TRANSMISSION_DOWNLOAD_DIR=/downloads/complete \
            TRANSMISSION_INCOMPLETE_DIR=/downloads/incomplete \
            TZ=UTC

COPY        root/ /

RUN         chmod +x /init && \
            apk add --no-cache \
                dumb-init \
                su-exec \
                transmission-cli \
                transmission-daemon \
                tzdata && \
            rm -rf /tmp/* /var/cache/apk/* /root/.cache && \
            mkdir /etc/transmission/web && \
            wget -qO- https://github.com/Secretmapper/combustion/archive/release.tar.gz | tar xz -C /etc/transmission/web && \
            wget -qO- https://github.com/endor/kettu/archive/master.tar.gz | tar xz -C /etc/transmission/web

HEALTHCHECK --interval=60s --timeout=15s --start-period=5s --retries=3 \
            CMD [ "/bin/ash", "-c", "/bin/netstat -lntp | /bin/grep -q -E '0.0.0.0:9091'" ]

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
