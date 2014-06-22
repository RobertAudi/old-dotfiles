# Attach to existing tmux session rather than create a new one if possible
tmux() {
  if ! (($#)) && command tmux has-session 2>/dev/null ; then
    EDITOR= VISUAL= command tmux attach-session -d
  else
    EDITOR= VISUAL= command tmux "$@"
  fi
}
