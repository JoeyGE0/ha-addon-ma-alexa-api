# Stage 1: Get the alexa-api image
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Stage 2: Build final image with HA base
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy everything from the alexa-api image
COPY --from=alexa-api / /

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
