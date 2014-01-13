function bundle --description="chgems aware bundle"
  type bundle > /dev/null

  if test $status -eq 0
    set -l gemfile_error (command bundle check --no-color)
    if test "$gemfile_error" = "Could not locate Gemfile"
      command bundle $argv
      return $status
    end

    if test (count (echo "$GEM_HOME" | command grep "$PWD/.gem")) -eq 0
      set -l check_chgems "false"

      if test (count $argv) -eq 0
        set check_chgems "true"
      else
        if test $argv[1] = "install"
          set check_chgems "true"
        end
      end

      if test $check_chgems = "true"
        read --local --prompt="set_color yellow; echo 'You are trying to run the bundle command to install gems'; echo 'but your gem environment is not isolated. Run `chgems` ?'; set_color normal; echo -n '(Type \'yes\' to confirm) '" run_chgems

        if test $run_chgems = "yes"
          chgems
        end
      end

    end

    command bundle $argv
  else
    set_color red
    echo "Bundler not installed!"
    set_color normal
    return 1
  end
end
