function cd --description="Change directory"
  if test -z $DASHDIRECTION
    set -g DASHDIRECTION "previous"
  end

  if test $argv[1] = - ^/dev/null
    if test -z $OLDPWD
      set -g OLDPWD $PWD
    end

    if test $DASHDIRECTION = "previous"
      if test $dirstack[1] = $PWD
        set -l old $PWD
        pushd $OLDPWD
        set -g OLDPWD $old
        set -g DASHDIRECTION "previous"
      else
        set -l old $PWD
        popd
        set -g OLDPWD $old
        set -g DASHDIRECTION "next"
      end
    else
      set -l old $PWD
      pushd $OLDPWD
      set -g OLDPWD $old
      set -g DASHDIRECTION "previous"
    end
  else
    set -l dir

    if test (count $argv) -eq 0
      set dir "$HOME"
    else
      set dir "$argv[1]"
    end

    if test $dir != $PWD
      set -g OLDPWD $PWD
    end

    pushd $dir

    set_color yellow
    echo -n "In: "
    pwd
    set_color normal
    /bin/ls -AG
  end
end
