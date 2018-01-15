#     Copyright 2015 Cedraro Andrea <a.cedraro@gmail.com>
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
#    limitations under the License.

#!/bin/bash
# Adapted from:
# https://github.com/pyca/cryptography/blob/master/.travis/install.sh

set -e

if [[ ${TRAVIS_OS_NAME} == "osx" ]]; then
  # install pyenv
  if [[ ! -d "$HOME/.pyenv/.git" ]]; then
    rm -rf ~/.pyenv
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
  else
    ( cd ~/.pyenv; git pull; )
  fi
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"

  case "${TOXENV}" in
    py26*)
      PYTHON_VERSION=2.6.9
      ;;
    py27*)
      PYTHON_VERSION=2.7.13
      ;;
    py33*)
      PYTHON_VERSION=3.3.6
      ;;
    py34*)
      PYTHON_VERSION=3.4.5
      ;;
    py35*)
      PYTHON_VERSION=3.5.2
      ;;
    py36*)
      PYTHON_VERSION=3.6.0
      ;;
  esac
  pyenv install -s "$PYTHON_VERSION"
  pyenv global "$PYTHON_VERSION"
  pyenv rehash
fi

pip install virtualenv
virtualenv ~/.venv
source ~/.venv/bin/activate
pip install tox
