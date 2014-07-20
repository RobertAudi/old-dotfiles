prompt_pwd() {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "~"
  else
    echo "%1C"
  fi
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

PROMPT='%{${fg_bold[green]}%}$(prompt_pwd)%{${reset_color}%} %{${fg[yellow]}%}$(prompt_char "○")%{${reset_color}%} '
