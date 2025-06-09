#!/usr/bin/env zsh

alias aliases="cd $XDG_CONFIG_HOME/zsh && $EDITOR custom/aliases.zsh && source $XDG_CONFIG_HOME/zsh/custom/aliases.zsh; cd -"
alias dflg="$HOMEBREW_PREFIX/bin/lazygit --git-dir=$XDG_DATA_HOME/repos/dotfiles --work-tree=$HOME"
alias dotfiles="/usr/bin/git --git-dir=$XDG_DATA_HOME/repos/dotfiles --work-tree=$HOME"
alias lg="$HOMEBREW_PREFIX/bin/lazygit"
alias nv="$EDITOR"
alias nvimc="cd ~/.config/nvim && $EDITOR && cd -"
alias repos="cd $XDG_DATA_HOME/repos"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias zshc="cd $XDG_CONFIG_HOME/zsh && $EDITOR && source "$HOME/.zshrc" && cd -"

[[ -x nproc ]] && alias make="make -j${nproc}"

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
