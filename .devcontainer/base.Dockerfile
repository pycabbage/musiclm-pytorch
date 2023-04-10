# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/devcontainers/base:jammy
ENV SCRIPTS_BASE=/opt/scripts.d

COPY .devcontainer/scripts.d ${SCRIPTS_BASE}
ENTRYPOINT [ "${SCRIPTS_BASE}/with-pyenv.sh" ]

RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > \
    /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  sudo ${SCRIPTS_BASE}/00-install-depends.sh

RUN ${SCRIPTS_BASE}/10-install-pyenv.sh 3.6
RUN ${SCRIPTS_BASE}/20-install-library.sh
RUN ${SCRIPTS_BASE}/99-cleanup.sh
