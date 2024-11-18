# FROM mcr.microsoft.com/devcontainers/base:ubuntu
FROM mcr.microsoft.com/devcontainers/python:3.10
LABEL maintainer="Nicholas Payne"

ARG DEBIAN_FRONTEND=noninteractive

ENV EDITOR=code

# run these things as the user
USER vscode

WORKDIR /home/vscode/devcontainer

COPY . .

RUN ./install.sh
WORKDIR /opt/docker
COPY --from=docker:dind /usr/local/bin/docker /opt/docker

WORKDIR /workspaces
