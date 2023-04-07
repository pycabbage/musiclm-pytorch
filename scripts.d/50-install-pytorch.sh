#!/bin/bash -e

TORCH_VERSION=1.13.1

cd /src

python3 -m pip install -U pip
pip3 install .
pip3 install "torch==${TORCH_VERSION}+cu117" torchaudio==0.13.1+cu117 --index-url https://download.pytorch.org/whl/cu117
