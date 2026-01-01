ARG BUILD_FROM
FROM ${BUILD_FROM}

# Multi-stage: get the alexa-api app from its image
FROM ghcr.io/alams154/music-assistant-alexa-api:latest AS alexa-api

# Back to HA base
FROM ${BUILD_FROM}

# Copy the alexa-api app files from its image
# We'll copy the entire app directory structure
COPY --from=alexa-api / /

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
