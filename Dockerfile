FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
ENV NEW_USERNAME musiclm
ENV PYENV_ROOT /opt/pyenv
ENV PYTHON_VERSION 3.7.14
# Python 3.7
# PyTorch 1.13
# CUDA 11.7

ARG MT_PATH /src

USER root

RUN --mount=source=scripts.d/00-unminimize.sh,target=${MT_PATH}/scripts.d/00-unminimize.sh \
  ${MT_PATH}/scripts.d/00-unminimize.sh
RUN --mount=source=scripts.d/10-install-depends.sh,target=${MT_PATH}/scripts.d/10-install-depends.sh \
  ${MT_PATH}/scripts.d/10-install-depends.sh
RUN --mount=source=scripts.d/20-install-cuda.sh,target=${MT_PATH}/scripts.d/20-install-cuda.sh \
  --mount=type=cache,target=/tmp/cudacache \
  mkdir /tmp/cudacache -p && ${MT_PATH}/scripts.d/20-install-cuda.sh
RUN --mount=source=scripts.d/25-add-normal-user.sh,target=${MT_PATH}/scripts.d/25-add-normal-user.sh \
  ${MT_PATH}/scripts.d/25-add-normal-user.sh

USER ${NEW_USERNAME}

RUN --mount=source=scripts.d/30-install-pyenv.sh,target=${MT_PATH}/scripts.d/30-install-pyenv.sh \
  ${MT_PATH}/scripts.d/30-install-pyenv.sh

COPY ./scripts/with-pyenv.sh /opt/with-pyenv.sh

SHELL [ "/opt/with-pyenv.sh" ]

RUN --mount=source=scripts.d/40-install-python.sh,target=${MT_PATH}/scripts.d/40-install-python.sh \
  ${MT_PATH}/scripts.d/40-install-python.sh

COPY --chown=${NEW_USERNAME}:${NEW_USERNAME} . ${MT_PATH}

RUN --mount=source=scripts.d/50-install-pytorch.sh,target=${MT_PATH}/scripts.d/50-install-pytorch.sh \
  --mount=source=setup.py,target=${MT_PATH}/setup.py \
  --mount=source=LICENSE,target=${MT_PATH}/LICENSE \
  --mount=source=musiclm_pytorch/,target=${MT_PATH}/musiclm_pytorch/ \
  cd ${MT_PATH}/ && ${MT_PATH}/scripts.d/50-install-pytorch.sh

RUN --mount=source=scripts.d/60-cleanup.sh,target=${MT_PATH}/scripts.d/60-cleanup.sh \
  ${MT_PATH}/scripts.d/60-cleanup.sh

COPY . ${MT_PATH}

ENTRYPOINT [ "/opt/with-pyenv.sh" ]
CMD [ "/bin/bash" ]
