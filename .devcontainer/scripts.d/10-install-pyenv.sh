#!/bin/bash -e

curl https://pyenv.run | bash

cat <<EOF >> ~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF

. ~/.bashrc

pyenv install $1
pyenv global $1
