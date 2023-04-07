FROM ubuntu:jammy
ARG DEBIAN_FRONTEND noninteractive
ARG PYTHON_VERSION 3.6.15

RUN sed -i.bak -e 's/upgrade/upgrade -y/' $(which unminimize) && \
  echo y | unminimize

RUN apt install -y --no-install-recommends ca-certificates git curl \
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev aria2

# Install cuda
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
  mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
  wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb && \
  apt install -y ./cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb && \
  cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/ && \
  apt update && \
  apt -y install cuda

RUN curl https://pyenv.run | PYENV_ROOT=/opt/pyenv bash

COPY . /src

SHELL [ "/src/scripts/with-pyenv.sh" ]

RUN pyenv doctor
RUN pyenv install ${PYTHON_VERSION:-3.6.15}
RUN pyenv global ${PYTHON_VERSION:-3.6.15}
RUN python3 -V
RUN python3 -m pip install -U pip
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118