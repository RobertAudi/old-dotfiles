# Copy path to file
pcf() {
  grealpath $1 | tr -d "\n" | pbcopy
}

# Pretty print the PATH
lspath () {
  local awkstr="{ sub(\"/usr\",    \"$fg_no_bold[green]/usr$reset_color\");"
  awkstr="${awkstr} sub(\"/bin\",  \"$fg_no_bold[blue]/bin$reset_color\");"
  awkstr="${awkstr} sub(\"/opt\",  \"$fg_no_bold[cyan]/opt$reset_color\");"
  awkstr="${awkstr} sub(\"/sbin\", \"$fg_no_bold[magenta]/sbin$reset_color\");"
  awkstr="${awkstr} sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\");"
  awkstr="${awkstr} print }"

  echo $PATH | tr ":" "\n" | awk "${awkstr}"
}

mcd() {
  command mkdir -p "$1"
  cd "$1"
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

# Use 'o' instead of 'open' (o ~/Sites will open the sites folder)
# If no arguments are supplied open the current folder
o() {
  open "${1:-.}"
}

nuke()
{
  local confirm
  read -q "confirm?Are you sure you want to delete \"${fg_no_bold[red]}${fg_bold[white]}${PWD}${reset_color}\"? [y/n]"

  local exitcode=$?

  if [[ "$confirm" == "y" ]]; then
    builtin cd ..

    command rm -rf $OLDPWD

    echo "${fg[yellow]}Nuked ${OLDPWD}!!!!$reset_color"
  fi

  return $exitcode
}

last_modified() {
  ls -t $* 2> /dev/null | head -n 1
}
