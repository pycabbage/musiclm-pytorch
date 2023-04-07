FROM ubuntu:lunar
ARG DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y --no-install-recommends curl

RUN curl https://pyenv.run | PYENV_ROOT=/opt/pyenv bash
