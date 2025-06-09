#!/usr/bin/env zsh

[ -d "$HOME/.local/state/zsh" ] || mkdir -p "$HOME/.local/state/zsh"
[ -d "$HOME/.cache/zsh" ] || mkdir -p "$HOME/.cache/zsh"

export ZSH="$HOME/.local/share/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh/custom"
export ZSH_CACHE_DIR="$ZSH/cache"

HISTFILE="$ZSH_CACHE_DIR/history"
HISTSIZE=10000
SAVEHIST=1000
bindkey -v

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

function ensure_plugin_installed() {
  local plugin_name=$(basename -s ".git" "$1")
  local plugin_path="${ZSH_CUSTOM}/plugins/${plugin_name}"

  if [ ! -d "$plugin_path" ]; then
    echo "Installing ZSH plugin: $plugin_name"
    git clone "$1" "$plugin_path" || echo "Failed to clone $plugin_name"
  fi
}

ensure_plugin_installed https://github.com/zdharma-continuum/fast-syntax-highlighting.git
ensure_plugin_installed https://github.com/zsh-users/zsh-autosuggestions.git
ensure_plugin_installed https://github.com/zsh-users/zsh-syntax-highlighting.git

unset -f ensure_plugin_installed

plugins=(
  copybuffer
  copyfile
  dirhistory
  fast-syntax-highlighting
  git
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
