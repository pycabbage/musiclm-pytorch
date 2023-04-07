#!/bin/bash -e

PYTHON_VERSION=${PYTHON_VERSION:-3.7.14}

pyenv doctor
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
python3 -V
