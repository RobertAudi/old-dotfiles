dot() {
  cd $HOME/.dotfiles
  echo "\n$fg[yellow]git status:$reset_color"

  if type gs > /dev/null 2>&1; then
    gs
  elif type git > /dev/null 2>&1; then
    git status
  else
    echo "$fg[red]git is not installed!$reset_color"
    return 1
  fi
}
