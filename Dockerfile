ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Use run.sh as entrypoint, original CMD will be passed as args
ENTRYPOINT ["/run.sh"]
