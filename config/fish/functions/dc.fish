function dc --description="Navigate to a parent directory"
  set -l __dc_arg (echo $argv[1] | tr '[:upper:]' '[:lower:]')
  set -l __dc_oldpwd (pwd | tr '[:upper:]' '[:lower:]')

  set -l __dc_newpwd (echo $__dc_oldpwd | sed 's|\(.*/'$__dc_arg'[^/]*/\).*|\1|')
  set -l __dc_index (echo $__dc_newpwd | awk '{ print index($0,"/'$__dc_arg'"); }')

  if test $__dc_index = 0
    set_color red
    echo "No such occurence."
    set_color normal
  else
    cd "$__dc_newpwd"
  end
end
