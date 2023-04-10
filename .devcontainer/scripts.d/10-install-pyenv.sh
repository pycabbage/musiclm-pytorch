#!/bin/bash -e

curl https://pyenv.run | bash

# cat <<EOF >> ~/.bashrc
# export PYENV_ROOT="\$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="\$PYENV_ROOT/bin:\$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# EOF

# . ~/.bashrc

${SCRIPTS_BASE}/with-pyenv.sh pyenv install $1
${SCRIPTS_BASE}/with-pyenv.sh pyenv global $1
