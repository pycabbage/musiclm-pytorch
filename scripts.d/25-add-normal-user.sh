#!/bin/bash -e

NEW_USERNAME=${NEW_USERNAME:-torch}

adduser --disabled-password --gecos "" $NEW_USERNAME
