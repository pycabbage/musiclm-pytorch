#!/bin/bash

PYENV_ROOT=/opt/pyenv
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

/bin/bash -c "$@"
