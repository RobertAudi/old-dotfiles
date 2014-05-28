rm() {
  local argument
  for argument in "$@"; do
    if [[ "$argument" == "-rf" || "$argument" == "-fr" || "$argument" == "-f" ]]; then
      echo "$fg[red]DO NOT FUCKING USE \`rm\` WITH THE \`-f\` FLAG!!!$reset_color"
      echo "$fg[yellow]Learn to you the \`trash\` command asshole!$reset_color"
      return 1
    fi
  done

  echo "$fg[yellow]Learn to you the \`trash\` command asshole!$reset_color"
  command rm -i "$@"
}
