FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
ENV NEW_USERNAME musiclm
ENV PYENV_ROOT /opt/pyenv
ARG PYTHON_VERSION 3.7.14
# Python 3.7
# PyTorch 1.13
# CUDA 11.7

RUN /src/scripts.d/00-unminimize.sh
RUN /src/scripts.d/10-install-depends.sh
RUN /src/scripts.d/20-install-cuda.sh
RUN /src/scripts.d/25-add-normal-user.sh

USER ${NEW_USERNAME}

RUN /src/scripts.d/30-install-pyenv.sh

COPY . /src

SHELL [ "/src/scripts/with-pyenv.sh" ]

RUN /src/scripts.d/40-install-python.sh

ENTRYPOINT [ "/src/scripts/with-pyenv.sh" ]
