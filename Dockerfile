FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
ENV NEW_USERNAME musiclm
ENV PYENV_ROOT /opt/pyenv
ARG PYTHON_VERSION 3.7.14
# Python 3.7
# PyTorch 1.13
# CUDA 11.7

USER root

RUN --mount=source=scripts.d/00-unminimize.sh,target=/src/scripts.d/00-unminimize.sh \
  /src/scripts.d/00-unminimize.sh
RUN --mount=source=scripts.d/10-install-depends.sh,target=/src/scripts.d/10-install-depends.sh \
  /src/scripts.d/10-install-depends.sh
RUN --mount=source=scripts.d/20-install-cuda.sh,target=/src/scripts.d/20-install-cuda.sh \
  --mount=type=cache,target=/tmp/cudacache \
  mkdir /tmp/cudacache -p && /src/scripts.d/20-install-cuda.sh
RUN --mount=source=scripts.d/25-add-normal-user.sh,target=/src/scripts.d/25-add-normal-user.sh \
  /src/scripts.d/25-add-normal-user.sh

USER ${NEW_USERNAME}

RUN /src/scripts.d/30-install-pyenv.sh

COPY ./scripts/with-pyenv.sh /opt/with-pyenv.sh

SHELL [ "/opt/with-pyenv.sh" ]

RUN --mount=source=scripts.d/40-install-python.sh,target=/src/scripts.d/40-install-python.sh \
  /src/scripts.d/40-install-python.sh

RUN --mount=source=scripts.d/50-install-pytorch.sh,target=/src/scripts.d/50-install-pytorch.sh \
  --mount=source=setup.py,target=/src/setup.py \
  --mount=source=musiclm_pytorch/,target=/src/musiclm_pytorch/ \
  cd /src/ && /src/scripts.d/50-install-pytorch.sh

COPY . /src

RUN /src/scripts.d/60-cleanup.sh

ENTRYPOINT [ "/opt/with-pyenv.sh" ]
