#!/bin/bash -e

PYTHON_VERSION=${PYTHON_VERSION:-3.6.15}

pyenv doctor
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
python3 -V
