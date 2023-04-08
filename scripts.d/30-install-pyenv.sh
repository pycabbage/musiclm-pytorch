#!/bin/bash -e

PYENV_ROOT=${PYENV_ROOT:-/opt/pyenv}
PYENV_ROOT_TMP=/tmp/pyenv

checkout() {
  [ -d "$2" ] || git -c advice.detachedHead=0 clone --branch "$3" --depth 1 "$1" "$2" || failed_checkout "$1"
}
failed_checkout() {
  echo "Failed to git clone $1"
  exit -1
}

if [ -n "${USE_SSH}" ]; then
  GITHUB="git@github.com:"
else
  GITHUB="https://github.com/"
fi

checkout "${GITHUB}pyenv/pyenv.git"            "${PYENV_ROOT_TMP}"                       "${PYENV_GIT_TAG:-master}"
sudo mv "${PYENV_ROOT_TMP}" "${PYENV_ROOT}"
checkout "${GITHUB}pyenv/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"      "master"
checkout "${GITHUB}pyenv/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"      "master"
checkout "${GITHUB}pyenv/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"  "master"
checkout "${GITHUB}pyenv/pyenv-ccache.git"     "${PYENV_ROOT}/plugins/pyenv-ccache"      "master"
