function popd --description "Pop dir from stack"
  if count $argv >/dev/null
    switch $argv[1]
      case -h --h --he --hel --help
        __fish_print_help popd
        return 0
    end
  end

  if test $dirstack[1]
    set -gx DASHDIRECTION "next"
    set -gx OLDPWD $PWD
    builtin cd $dirstack[1]
  else
    echo "Directory stack is empty..."
    return 1
  end

  set -e dirstack[1]
end
