FROM debian:latest as builder
LABEL maintainer="dziubamaksym@pm.me"
SHELL ["/bin/bash", "-c"]
WORKDIR /nomad
ARG NOMAD_VERSION
ARG DEBIAN_FRONTEND=noninteractive
ENV NOMAD_VERSION=$NOMAD_VERSION
RUN apt-get update && \
  apt-get --yes --no-install-recommends install \
  ca-certificates \
  wget \
  unzip && \
  apt-get autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
  wget --quiet https://releases.hashicorp.com/nomad/"$NOMAD_VERSION"/nomad_"$NOMAD_VERSION"_linux_amd64.zip && \
  unzip /nomad/nomad_"$NOMAD_VERSION"_linux_amd64.zip && \
  rm -rf nomad_"$NOMAD_VERSION"_linux_amd64.zip && \
  mv nomad /usr/bin && \
  nomad -version