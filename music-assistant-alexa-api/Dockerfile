ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use run.sh as entrypoint
ENTRYPOINT ["/run.sh"]
