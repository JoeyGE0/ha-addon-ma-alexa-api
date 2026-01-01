ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install docker-cli to run the alexa-api container
RUN apk add --no-cache docker-cli

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
