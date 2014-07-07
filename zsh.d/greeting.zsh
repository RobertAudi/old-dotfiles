greeting() {
  [[ $already_sourced_once == 1 ]] && return

  already_sourced_once=1

  if [[ "$TERM" != "screen-256color" || -z "$TMUX" ]]; then
    if $(tmux list-sessions > /dev/null 2>&1); then
      tmux a
    else
      tmux
    fi
  else
    count_files
    list_of_files
  fi
}

greeting
