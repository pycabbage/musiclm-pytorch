#!/bin/bash

# Remove cuda deb file
sudo rm -fr /tmp/cudacache/
# Remove pip cache
pip3 cache purge

# remove unnecessary package
sudo apt-get remove -y libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev ccache aria2 gnupg

# Remove apt cache
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
