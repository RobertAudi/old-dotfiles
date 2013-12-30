function back --description=""
  set -l old $PWD
  popd
  set -g OLDPWD $old
  set -g DASHDIRECTION "next"
end
