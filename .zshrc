#!/usr/bin/env zsh

for file in ~/.config/zsh/*; do
  source "$file"
done

source $ZSH/oh-my-zsh.sh
