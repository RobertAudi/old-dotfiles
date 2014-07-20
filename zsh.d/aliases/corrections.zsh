load_corrections() {
  setopt correct_all

  local corrections
  corrections=( man mv mkdir curl rake make )

  local correction
  for correction in $corrections; do
    alias $correction="nocorrect $correction"
  done

  SPROMPT="$fg[red]%R →$reset_color $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "
}

