function fish_prompt
  __dot_flush_options

  autojump -a $PWD > /dev/null &

  set -l green (set_color -o green)
  set -l yellow (set_color -o yellow)
  set -l normal (set_color normal)

  echo -n -s $green(prompt_pwd) ' ' $yellow(prompt_char) $normal ' '
end
