#!/bin/bash -e

# Remove cuda deb file
rm -fr /tmp/cudacache/
pip3 cache purge
