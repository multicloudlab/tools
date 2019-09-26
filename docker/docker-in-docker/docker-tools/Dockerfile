FROM ubuntu:xenial

# Installing
COPY docker-tools/install.sh /tmp/tools/
RUN chmod -R +x /tmp/tools/install.sh
RUN /tmp/tools/install.sh && rm -rf /tmp/tools

# Docker in Docker settings
VOLUME /var/lib/docker
EXPOSE 2375

ENV PATH /usr/lib/google-cloud-sdk/bin:${PATH}

# COPY entrypoint to start docker
COPY docker-tools/prow-runner.sh /usr/local/bin/entrypoint
RUN chmod +rx /usr/local/bin/entrypoint

# Set CI variable which can be checked by test scripts to verify
# if running in the continuous integration environment.
ENV CI prow

ENTRYPOINT ["entrypoint"]
