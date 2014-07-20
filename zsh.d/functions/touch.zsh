touch() {
  if [[ $# -eq 0 ]]; then
    echo "$fg[red]You need to specify at least one file to touch$reset_color"
    return 1
  fi

  local f
  for f in $@; do
    if [[ -a $f ]]; then
      echo "$fg[red]$f already exists$reset_color"
      continue
    fi

    local directory=$(dirname $f)

    if [[ ! -d $directory ]]; then
      local answer
      vared -p "$directory doesn't exist. Do you want to create it? " answer

      if [[ $answer =~ "^[yY]" ]]; then
        command mkdir -p $directory
        answer=
      else
        echo "$fg[red]No such file or directory: $directory$reset_color"
        continue
      fi
    fi

    command touch $f
  done
}
