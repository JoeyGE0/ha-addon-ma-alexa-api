# Stage 1: Get the alexa-api image  
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Stage 2: Build final image with HA base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Copy app files from alexa-api image
# Copy to temp location first, then move if they exist
COPY --from=alexa-api / /tmp/alexa-api/

# Move files selectively (only if they exist)
RUN \
    if [ -d /tmp/alexa-api/app ]; then cp -r /tmp/alexa-api/app /app; fi && \
    if [ -d /tmp/alexa-api/usr/src/app ]; then cp -r /tmp/alexa-api/usr/src/app /usr/src/app; fi && \
    if [ -d /tmp/alexa-api/opt ]; then cp -r /tmp/alexa-api/opt /opt; fi && \
    if [ -f /tmp/alexa-api/package.json ]; then cp /tmp/alexa-api/package.json /package.json; fi && \
    if [ -d /tmp/alexa-api/node_modules ]; then cp -r /tmp/alexa-api/node_modules /node_modules; fi && \
    rm -rf /tmp/alexa-api

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
