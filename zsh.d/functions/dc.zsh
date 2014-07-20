dc () {
  if (( $# < 1 )); then
    echo "Usage: $0 <name-of-any-parent-directory>"
    return 1
  fi

  # Get parents (in reverse order)
  local parents
  local num=${#${(ps:/:)${PWD}}}
  local i

  for i in {$(( num + 1 ))..2}; do
    parents=( $parents "$(echo $PWD | cut -d'/' -f$i)" )
  done

  parents=($parents "/")

  # Build dest and 'cd' to it
  local dest="./"
  local parent

  for parent in $parents; do
    if [[ $1 == $parent ]]; then
      cd $dest
      return 0
    fi

    dest="$dest../"
  done

  echo "$fg[red]$0: Error: No parent directory named '$1'$reset_color"
  return 1
}

_dc () {
  # Get parents (in reverse order)
  local num=${#${(ps:/:)${PWD}}}
  local i
  for i in {$((num+1))..2}; do
    reply=($reply "$(echo $PWD | cut -d'/' -f$i)")
  done

  reply=($reply "/")
}

compctl -V directories -K _dc dc
