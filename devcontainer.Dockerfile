FROM mcr.microsoft.com/devcontainers/base:ubuntu
LABEL maintainer="Nicholas Payne"

ARG DEBIAN_FRONTEND=noninteractive

ENV EDITOR=code

# run these things as the user
USER vscode

WORKDIR /home/vscode/dotfiles

COPY . .

RUN ./install.sh

WORKDIR /workspaces
