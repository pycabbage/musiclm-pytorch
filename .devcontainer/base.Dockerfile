# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/devcontainers/base:jammy
ARG USERNAME=musiclm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SCRIPTS_BASE=/opt/scripts.d

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

COPY .devcontainer/scripts.d ${SCRIPTS_BASE}
ENTRYPOINT [ "${SCRIPTS_BASE}/with-pyenv.sh" ]

RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > \
    /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  ${SCRIPTS_BASE}/00-install-depends.sh

USER $USERNAME
RUN ${SCRIPTS_BASE}/10-install-pyenv.sh 3.6
RUN ${SCRIPTS_BASE}/20-install-library.sh
RUN ${SCRIPTS_BASE}/99-cleanup.sh
