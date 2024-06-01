FROM lscr.io/linuxserver/code-server:latest
LABEL maintainer="Nicholas Payne"

ARG DEBIAN_FRONTEND=noninteractive
ARG PIP_INDX_URL
ARG PY_VERSION="3.10.12"

# TODO: what to do about podman?
ENV DOCKER_HOST tcp://localhost:2375
ENV PATH /app/code-server/bin:${PATH}
ENV EDITOR code-server

EXPOSE 8443

# Install sudo and add user abc to sudoers
RUN apt-get update && apt-get install -y sudo \
  && echo "abc ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abc

WORKDIR /config/dotfiles
USER abc
# try sudo chowning as abc?
RUN sudo chown -R abc:abc /config
COPY . .
RUN ./install.sh
# TODO: For SSL https://github.com/linuxserver/docker-mods/tree/code-server-ssl

# Staying abc broke starting up the code-server
USER root
