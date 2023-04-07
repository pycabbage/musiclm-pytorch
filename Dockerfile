FROM ubuntu:lunar
ARG DEBIAN_FRONTEND noninteractive
ARG PYTHON_VERSION 3.6.15

RUN sed -i.bak -e 's/upgrade/upgrade -y/' $(which unminimize) && \
  echo y | unminimize
RUN apt install -y --no-install-recommends ca-certificates git build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

RUN curl https://pyenv.run | PYENV_ROOT=/opt/pyenv bash

COPY . /src

SHELL [ "/src/scripts/with-pyenv.sh" ]

RUN pyenv doctor
RUN pyenv install "${PYTHON_VERSION}"
