#!/usr/bin/env zsh

alias dhd="cd ~/src/heimdall"
alias dhdr="cd $HOME/.local/share/repos/heimdall"
alias repos="cd $HOME/.local/share/repos"
alias nv="$EDITOR"

alias aliases="$EDITOR ~/.config/zsh/custom/aliases.zsh ; source ~/.config/zsh/custom/aliases.zsh"
alias dflg="$HOMEBREW_PREFIX/bin/lazygit --git-dir=$HOME/.local/share/repos/dotfiles --work-tree=$HOME"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.local/share/repos/dotfiles --work-tree=$HOME"
alias lg="$HOMEBREW_PREFIX/bin/lazygit"
alias notes="cd ~/Nextcloud/Notes && $EDITOR -c \"lua require('persistence').load()\" && cd -"
alias nvimc="cd ~/.config/nvim && $EDITOR && cd -"
alias wget="wget --hsts-file=$HOME/.cache/wget-hsts"
alias zshc="cd $HOME/.config/zsh && $EDITOR && cd -"

[[ -x nproc ]] && alias make="make -j${nproc}"

if [[ $(uname) == "Darwin" ]]; then
  alias ls="ls -G"
elif [[ $(uname) == "Linux" ]]; then
  alias ls="ls --color=auto"
fi
