FROM mcr.microsoft.com/devcontainers/base:ubuntu
LABEL maintainer="Nicholas Payne"

ARG DEBIAN_FRONTEND=noninteractive

ARG GH_ACTIONS=false
ENV GH_ACTIONS=${GH_ACTIONS}
ENV EDITOR=code

# run these things as the user
USER vscode

WORKDIR /home/vscode/dotfiles

COPY . .

RUN ./install.sh

WORKDIR /workspaces
