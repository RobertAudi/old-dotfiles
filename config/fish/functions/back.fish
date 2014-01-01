function back --description=""
  if test -z $OLDPWD
    set -gx OLDPWD $PWD
  end

  if test $DASHDIRECTION = "previous"
    if test $dirstack[1] = $PWD
      set -l old $PWD
      pushd $OLDPWD
      set -gx OLDPWD $old
      set -gx DASHDIRECTION "previous"
    else
      set -l old $PWD
      popd
      set -gx OLDPWD $old
      set -gx DASHDIRECTION "next"
    end
  else
    set -l old $PWD
    pushd $OLDPWD
    set -gx OLDPWD $old
    set -gx DASHDIRECTION "previous"
  end
end
