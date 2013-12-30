function __dot_update --description="Update packages"
  set -l response_code 0

  set -l __dot_number_of_packages_updated 0

  # options
  set -l __opt_force

  if test $OPTC -gt 0
    for opt in $OPTV
      switch "$opt"
      case "-f" "--force"
        set __opt_force "__FORCE__"
      case "*"
        set_color red
        echo "dot: Invalid option '$opt'"
        set_color normal

        return 1
      end
    end
  end

  set -l __packages_to_update

  if test $ARGC -gt 0
    for arg in $ARGV
      if contains $arg $DOT_PACKAGES
        set __packages_to_update $__packages_to_update $arg
      else
        set_color yellow
        echo "Package not found: $arg"
        set_color normal
      end
    end
  else
    set __packages_to_update $DOT_PACKAGES
  end


  for package in $__packages_to_update
    set -l package_dir "$HOME/.$package"

    if not test -d $package_dir
      set_color red
      echo "$package does not seem to be installed"
      set_color yellow
      echo "You can install $package using `dot install $package`"
      set_color normal
      continue
    end

    set -l previous_pwd $PWD
    /usr/bin/cd $package_dir

    set -l upstrean_changes (count (git log HEAD..origin/master --oneline > /dev/null ^/dev/null))

    if test $upstrean_changes -eq 0
      set_color yellow
      echo "$package is already up-to-date"
      set_color normal
      continue
    end

    set -l changes (count (git status --porcelain > /dev/null ^/dev/null))
    set -l commits (count (git log --branches --not --remotes --oneline > /dev/null ^/dev/null))

    set -l clean_count (math $changes + $commits)

    set -l current_branch (git branch | sed -n '/\* /s///p')

    if test $clean_count -gt 0
      set_color yellow

      echo "The $package repo is not clean"

      if test $commits -gt 0
        echo ""
        echo "There are $commits commits to be pushed accross branches"
      end

      if test $changes -gt 0
        if test $commits -eq 0
          echo ""
        end

        echo "There are $changes changes to be commited on the '$current_branch' branch"
      end

      echo ""

      set_color normal

      if test $__opt_force = "__FORCE__"
        read --local --prompt="set_color yellow; echo 'Are you REALLY sure that you want update $package?'; echo 'You might lose local commits in the process!'; 'echo -n '(Type \'YES\' to confirm) '; set_color normal" force_check

        if test $force_check = "YES"
          set_color yellow
          echo "Updating $package..."
          set_color normal

          git stash --include-untracked > /dev/null ^/dev/null

          git checkout master > /dev/null ^/dev/null

          git pull --rebase origin master > /dev/null ^/dev/null

          if test $status -ne 0
            set response_code (math $response_code + 1)

            git rebase --abort > /dev/null ^/dev/null

            git reset --hard origin/master > /dev/null ^/dev/null

            git pull --rebase origin master > /dev/null ^/dev/null

            if test $status -ne 0
              git rebase --abort > /dev/null ^/dev/null

              set_color red
              echo "Update of $package failed"
              set_color normal

              set response_code (math $response_code + 1)
            else
              set_color red
              echo "Some local commits have been lost in the $package repo"
              set_color normal
            end
          else
            set __dot_number_of_packages_updated (math $__dot_number_of_packages_updated + 1)
          end

          git stash pop > /dev/null ^/dev/null
        end
      end

      continue
    end

    set_color yellow
    echo "Updating $package..."
    set_color normal

    git checkout master > /dev/null ^/dev/null

    git pull --rebase origin master > /dev/null ^/dev/null

    set __dot_number_of_packages_updated (math $__dot_number_of_packages_updated + 1)
  end

  echo ""

  if test $response_code -gt 0
    set_color yellow
    echo "Some packages failed to get updated"
    set_color normal
  end

  if test $__dot_number_of_packages_updated -eq 0
    set_color yellow
    echo "No packages updated"
    set_color normal
  else
    set_color green
    echo "$__dot_number_of_packages_updated packages updated"
    set_color normal
  end

  return $response_code
end
