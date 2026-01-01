# Stage 1: Get the alexa-api image  
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Stage 2: Build final image with HA base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script first
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Copy everything from alexa-api, but preserve HA base critical files
# Copy to a temp location first, then move selectively
COPY --from=alexa-api / /tmp/alexa-api/

# Move app files (preserve HA base's /init, /usr/bin, etc.)
RUN \
    if [ -d /tmp/alexa-api/app ]; then cp -r /tmp/alexa-api/app /app; fi && \
    if [ -d /tmp/alexa-api/usr/src/app ]; then cp -r /tmp/alexa-api/usr/src/app /usr/src/app; fi && \
    if [ -d /tmp/alexa-api/opt ]; then cp -r /tmp/alexa-api/opt /opt; fi && \
    if [ -f /tmp/alexa-api/package.json ]; then cp /tmp/alexa-api/package.json /package.json; fi && \
    rm -rf /tmp/alexa-api

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
