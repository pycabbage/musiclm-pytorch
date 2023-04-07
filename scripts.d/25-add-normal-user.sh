#!/bin/bash -e

NEW_USERNAME=${NEW_USERNAME:-torch}

adduser --disabled-password --gecos "" $NEW_USERNAME
echo "$NEW_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$NEW_USERNAME
visudo -c
