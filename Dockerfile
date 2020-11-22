FROM        alpine

LABEL       maintainer="ksurl"

WORKDIR     /config

VOLUME      /config /downloads

EXPOSE      9091 51413

ENV         PUID=1000 \
            PGID=1000 \
            TRANSMISSION_HOME=/config \
            TRANSMISSION_DOWNLOAD_DIR=/downloads/complete \
            TRANSMISSION_INCOMPLETE_DIR=/downloads/incomplete \
            TZ=UTC

COPY        init /init
COPY        settings.json /etc/transmission/settings.json
RUN         chmod +x /init && \
            apk add --no-cache \
                #bash \
                dumb-init \
                su-exec \
                transmission-cli \
                transmission-daemon \
                tzdata && \
            rm -rf /tmp/* /var/cache/apk/* /root/.cache && \
            mkdir /etc/transmission/web && \
            wget -qO- https://github.com/Secretmapper/combustion/archive/release.tar.gz | tar xz -C /etc/transmission/web && \
            wget -qO- https://github.com/endor/kettu/archive/master.tar.gz | tar xz -C /etc/transmission/web

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "/init" ]
