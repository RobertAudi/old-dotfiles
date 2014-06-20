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
  grealpath $1 | tr -d '\n' | pbcopy
}

# Pretty print the PATH
lspath () {
  eval echo \$${1:-PATH} |tr : '\n'
}
