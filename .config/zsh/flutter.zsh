#!/usr/bin/env zsh

flutter_home="$XDG_DATA_HOME/repos/flutter"

if [[ -d "$flutter_home" ]]; then
  export FLUTTER_HOME="$XDG_DATA_HOME/repos/flutter"
  export PATH="$FLUTTER_HOME/bin:$PATH:$HOME/.pub-cache/bin"

  [[ $(uname) == "Darwin" ]] && alias flutter="flutter -d macos"
fi

unset flutter_home
