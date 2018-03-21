export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"
GREP_OPTIONS="--color=always";export GREP_OPTIONS
export PATH=$PATH:$HOME/.nodebrew/current/bin
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
