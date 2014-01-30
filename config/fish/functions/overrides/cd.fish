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
      if test (count (echo "$argv[1]" | command grep -E "\.\.\.+")) -eq 1
        set -l tmp_dir "$argv[1]"
        # echo -n "$tmp_dir" | sed -E "s/(\.\.?\/)*(\.\.\.+)/\2/g" | tr -d '\n' | wc -c | sed -E "s/^[ \t]*//g"

        while test (echo -n "$tmp_dir" | sed -E "s/(\.\.?\/)*(\.\.\.+)/\2/g") != (echo -n "$tmp_dir" | sed -E "s/((\.\.?\/)*)(\.)(\.{2,})\$/\1.\3\/\4/")
          set tmp_dir (echo -n "$tmp_dir" | sed -E "s/((\.\.?\/)*)(\.)(\.{2,})\$/\1.\3\/\4/")
        end

        set dir "$tmp_dir"
      else
        set dir "$argv[1]"
      end
    end

    if test $dir != $PWD
      set -gx OLDPWD $PWD
    end

    pushd $dir

    if test (count (pwd | command grep "$HOME")) -eq 0
      set_color yellow
      echo "Warning: You got out of your home directory!"
      set_color normal
    end

    set_color yellow
    echo -n "In: "
    pwd
    set_color normal
    command ls -AG
  end

  type chgems > /dev/null

  if test $status -eq 0
    if test -d ".gem"
      chgems
    end
  end
end
