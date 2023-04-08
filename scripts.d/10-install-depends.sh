#!/bin/bash -e

apt-get update
apt-get upgrade -y --no-install-recommends
apt-get install -y --no-install-recommends ca-certificates git curl \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev ccache \
  aria2 gnupg sudo
