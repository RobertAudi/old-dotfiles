prompt_pwd() {
  local pwdstr

  if [[ "$PWD" == "$HOME" ]]; then
    pwdstr="~"
  else
    pwdstr="%1C"
  fi

  local pwdcolor

  if [[ -w "$PWD" ]]; then
    pwdcolor="green"
  else
    pwdcolor="red"
  fi

  echo "%{${fg_bold[${pwdcolor}]}%}${pwdstr}%{${reset_color}%}"
}

prompt_char() {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  bzr root >/dev/null 2>/dev/null && echo '↥' && return
  if (( $# == 0 )); then
    echo '$'
  else
    echo $1
  fi
}

jobscount() {
  local running=$(( $(jobs -r | wc -l) ))
  local stopped=$(( $(jobs -s | wc -l) ))

  if (( $running == 0 )); then
    running=""
  else
    running="%{${fg[cyan]}%}${running}%{${reset_color}%}"
  fi

  if (( $stopped == 0 )); then
    stopped=""
  else
    stopped="%{${fg[blue]}%}${stopped}%{${reset_color}%}"
  fi

  local countstr="$running $stopped"
  countstr="${${${${countstr##([[:space:]]#)}%%([[:space:]]#)}}/ /:}"

  [[ -n "$countstr" ]] && countstr="($countstr)"

  echo "$countstr"
}

precmd() {
  exit_status=$?
  if [[ "$ran_something" == "0" ]]; then
    exit_status=0
  fi

  ran_something=0
}

preexec() {
  ran_something=1
}

show_non_zero_exit_status() {
  case $exit_status in
    0|18|130)
      ;;
    *)
      echo "%{${fg[red]}%}!!%{${reset_color}%}"
      ;;
  esac
}

genprompt() {
  local prompt="$(show_non_zero_exit_status) $(jobscount) $(prompt_pwd) %{${fg[yellow]}%}$(prompt_char "○")%{${reset_color}%}"
  echo "${prompt##([[:space:]]#)} "
}


PROMPT='$(genprompt)'
