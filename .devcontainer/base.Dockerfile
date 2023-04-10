FROM mcr.microsoft.com/devcontainers/base:jammy

COPY .devcontainer/scripts.d /opt/scripts.d

RUN /opt/scripts.d/00-install-depends.sh
RUN /opt/scripts.d/10-install-pyenv.sh 3.6
RUN /opt/scripts.d/20-install-library.sh
RUN /opt/scripts.d/99-cleanup.sh
