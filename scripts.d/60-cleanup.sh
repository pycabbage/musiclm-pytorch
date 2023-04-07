#!/bin/bash -e

# Remove cuda deb file
rm -fr /tmp/cudacache/
# Remove pip cache
pip3 cache purge

# Remove apt cache
apt-get clean
rm -rf /var/lib/apt/lists/*
