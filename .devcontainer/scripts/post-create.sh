#!/usr/bin/env zsh
set -xe
git config --global pull.rebase true
git config --global --add safe.directory /workspace
git config --global gpg.format ssh && git config --global user.signingkey "$SSH_SIGNING_KEY"
git config --global commit.gpgsign true
if git config --global gpg.ssh.program; then
  echo "Unsetting gpg.ssh.program"
  git config --global --unset gpg.ssh.program
fi
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
pip install -r /workspace/requirements.txt
