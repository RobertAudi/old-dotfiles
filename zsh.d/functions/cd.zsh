_autoenv() {
  if [[ $# -ne 1 ]]; then
    echo "$fg[red]Invalid number of arguments ($#) supplied to the _autoenv function!$reset_color"
    return 1
  fi

  local directory="$PWD"
  local target="$(realpath "$1")"

  [[ "$directory" == "$target" ]] && return

  local directory_slashes=${directory//[^\/]/}
  local target_slashes=${target//[^\/]/}

  local envars
  envars=()

  for (( n=${#directory_slashes}; n > 0; --n )); do
    [[ "$directory" == "$HOME" ]] && break

    if [[ -f "$directory/.env" ]]; then
      envars=( $envars $(cat "$directory/.env" | sed "s/=.*//g" | tr '\n' ' ') )
    fi

    [[ "$directory" == "$target" ]] && break

    directory="$directory/.."
  done

  if [[ ${#envars[@]} -gt 0 ]]; then
    for envar in $envars; do
      unset $envar
    done

    unset envar
  fi

  envars=()

  for (( n=${#target_slashes}; n > 0; --n )); do
    [[ "$target" == "$HOME" ]] && break

    if [[ -f "$target/.env" ]]; then
      envars=( $(cat "$target/.env" | tr '\n' ' ') $envars )
    fi

    target="$target/.."
  done

  if [[ ${#envars[@]} -gt 0 ]]; then
    for envar in $envars; do
      export $envar
    done

    unset envar
  fi
}

cd() {
  if [[ $# -eq 0 ]]; then
    local directory="$HOME"
  else
    local directory="$1"
  fi

  if [[ "$directory" != "-" && ! -d $directory ]]; then
    if [[ -f $directory ]]; then
      echo "$fg[red]$directory is a file!$reset_color"
      return 1
    fi

    local answer
    vared -p "$directory doesn't exist. Do you want to create it? " answer

    if [[ $answer =~ "^[yY]" ]]; then
      command mkdir -p $directory
    else
      echo "$fg[red]No such file or directory: $directory$reset_color"
      return 1
    fi
  fi

  _autoenv "$directory"

  builtin pushd $directory > /dev/null

  if [[ -z $(pwd | command grep "$HOME") ]]; then
    echo "$fg[yellow]You got out of your home directory!$reset_color"
  fi

  echo "$fg[yellow]In: $PWD$reset_color"
  command ls -pFA --color=auto
}

_up() {
  local rx updir
  rx=$(ruby -e "print '$1'.gsub(/\s+/,'').split('').join('.*?')")
  updir=`echo $PWD | ruby -e "print STDIN.read.sub(/(.*\/${rx}[^\/]*\/).*/i,'\1')"`
  echo -n "$updir"
}

up() {
  if [ $# -eq 0 ]; then
    echo "up: traverses up the current working directory to first match and cds to it"
    echo "You need an argument"
  else
    cd $(_up "$@")
  fi
}
