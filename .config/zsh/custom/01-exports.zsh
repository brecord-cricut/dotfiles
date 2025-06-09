#!/usr/bin/env zsh

export EDITOR="nvim"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export REPOS="$XDG_DATA_HOME/repos"

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
