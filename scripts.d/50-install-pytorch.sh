#!/bin/bash -e

cd /src

python3 -m pip install -U pip pipenv
# pip3 install .
# pip3 install torch==1.13.1+cu117 torchaudio==0.13.1+cu117 --index-url https://download.pytorch.org/whl/cu117

pippenv lock
pipenv install --system --deploy
