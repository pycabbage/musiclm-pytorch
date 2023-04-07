#!/bin/bash

UNMINIMIZE_PATH=$(which unminimize)

cat $UNMINIMIZE_PATH | \
  sed -e 's/^read/# read/' | \
  sed -E 's/^( +)(exit 1)$/\1# \2\n\1echo/gi' | \
  sed -e 's/upgrade$/upgrade -y/' > \
  "${UNMINIMIZE_PATH}.new"
mv $UNMINIMIZE_PATH "${UNMINIMIZE_PATH}.bak"
mv "${UNMINIMIZE_PATH}.new" $UNMINIMIZE_PATH
chmod +x $UNMINIMIZE_PATH

unminimize
