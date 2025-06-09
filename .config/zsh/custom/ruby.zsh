#!/usr/bin/env zsh

if command -v rbenv >>/dev/null; then
  eval "$(rbenv init -)"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export PATH="$GEM_HOME/bin:$PATH"
fi
