tree() {
  local depth=0
  local target="."

  if (( $# >= 1 )); then
    if [[ "$1" =~ "^[0-9]+$" ]]; then
      depth="$1"

      if [[ "$2" != "" ]]; then
        target="$2"
      fi
    else
      target="$1"
    fi
  fi

  local cmd="command tree -CAFa -I 'rhel.*.*.package|.git|.gem' --dirsfirst"

  if (( $depth > 0 )); then
    cmd="$cmd -L $depth"
  fi

  cmd="$cmd $target"

  eval "$cmd"
}
