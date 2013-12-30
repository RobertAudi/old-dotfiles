function prompt_char
  if [ (command git symbolic-ref HEAD ^/dev/null) ]
    echo '±'
  else if [ (command hg root ^/dev/null) ]
    echo '☿'
  else
    echo '○'
  end
end
