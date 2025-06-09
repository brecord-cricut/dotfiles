#!/usr/bin/env zsh

## Check if Git author information is missing

if [ -f ~/.config/git/.env ]; then
  source ~/.config/git/.env
fi

# Check if Git author information is missing after sourcing .env
if [[ -z "$GIT_AUTHOR_NAME" || -z "$GIT_AUTHOR_EMAIL" ]]; then
  echo "git user context is missing."
  if [[ -z "$GIT_AUTHOR_NAME" ]]; then
    echo -n "Enter your Git author name: "
    read git_name
  fi
  if [[ -z "$GIT_AUTHOR_EMAIL" ]]; then
    echo -n "Enter your Git author email: "
    read git_email
  fi
  if [[ -z "$git_name" || -z "$git_email" ]]; then
    echo "Error: Both Git author name and email are required."
    return 1
  fi
  mkdir -p ~/.config/git
  {
    echo "#!/usr/bin/env zsh"
    echo "export GIT_AUTHOR_NAME=\"$git_name\""
    echo "export GIT_AUTHOR_EMAIL=\"$git_email\""
    echo "export GIT_COMMITTER_NAME=\"$git_name\""
    echo "export GIT_COMMITTER_EMAIL=\"$git_email\""
  } >~/.config/git/.env
  source ~/.config/git/.env
  unset git_name git_email
fi
