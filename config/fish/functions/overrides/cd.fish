function cd --description="Change directory"
  if test -z $DASHDIRECTION
    set -gx DASHDIRECTION "previous"
  end

  if test $argv[1] = - ^/dev/null
    back
  else
    set -l dir

    if test (count $argv) -eq 0
      set dir "$HOME"
    else
      set dir "$argv[1]"
    end

    if test $dir != $PWD
      set -gx OLDPWD $PWD
    end

    pushd $dir

    set_color yellow
    echo -n "In: "
    pwd
    set_color normal
    command ls -AG
  end
end
