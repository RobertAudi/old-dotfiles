# Syntax highlighted cat
ccat() {
  if ! type pygmentize > /dev/null 2>&1; then
    echo "$fg[red]pygments not installed!$reset_color"
    return 1
  fi

  if [[ $# -eq 0 ]]; then
    echo "Usage: ccat <filename>"
    return
  fi

  pygmentize -g "$@"
}

# Copy path to file
pcf() {
  grealpath $1 | tr -d "\n" | pbcopy
}

# Pretty print the PATH
lspath () {
  eval echo \$${1:-PATH} |tr : "\n"
}

fasd_cd() {
  if [[ "$2" == "-i" ]]; then
    cd $(fasd -id "$1" )
  else
    cd $(fasd -d "$1" -1)
  fi
}

# Determine size of a file or total size of a directory
fs() {
  if [[ -n "$@" ]]; then
    command du -sbh -- "$@"
  else
    command du -csbh .[^.]* *
  fi
}
