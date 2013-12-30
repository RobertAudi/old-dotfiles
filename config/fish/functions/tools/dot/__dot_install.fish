function __dot_install --description="Install packages"
  set -l response_code 0

  set -g __dot_number_of_packages_installed 0

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

  set -l __packages_to_install

  if test $ARGC -gt 0
    for arg in $ARGV
      if contains $arg $DOT_PACKAGES
        set __packages_to_install $__packages_to_install $arg
      else
        set_color yellow
        echo "Package not found: $arg"
        set_color normal
      end
    end
  else
    set __packages_to_install $DOT_PACKAGES
  end

  for package in $__packages_to_install
    set -l repo "git@github.com:AzizLight/$package.git"
    set -l destination "$HOME/.$package"

    if test "$__opt_force" = "__FORCE__"
      if test -d "$destination"
        read --local --prompt="set_color yellow; echo 'Are you sure that you want to replace $package by a fresh copy?'; echo -n '(Type \'yes\' to confirm) '; set_color normal" force_check

        if test $force_check = "yes"
          set -l previous_pwd $PWD
          /usr/bin/cd $destination

          set -l changes (count (git status --porcelain > /dev/null ^/dev/null))

          /usr/bin/cd $previous_pwd

          if test $changes -gt 0

            read --local --prompt="set_color yellow; echo '$package is dirty! Are you REALLY sure that you want to replace it by a fresh copy?'; echo -n '(Type \'YES\' to confirm) '; set_color normal" force_check

            if test $force_check = "YES"

              set_color red
              echo "Removing $package..."
              set_color normal

              /bin/rm -rf $destination > /dev/null
            end
          else
            set_color red
            echo "Removing $package..."
            set_color normal

            /bin/rm -rf $destination > /dev/null
          end
        else
          continue
        end
      end
    end

    if not test -d "$destination"
      __dot_install_single $package $repo $destination
      set -l response_code (math $response_code + $status)
      continue
    end

    set_color yellow
    echo "$package already installed. Run `dot update $package` to update it"
    set_color normal
  end

  echo ""

  if test $response_code -gt 0
    set_color yellow
    echo "Some packages failed to get installed"
    set_color normal
  end

  if test $__dot_number_of_packages_installed -eq 0
    set_color yellow
    echo "No packages installed"
    set_color normal
  else
    set_color green
    echo "$__dot_number_of_packages_installed packages installed"
    set_color normal
  end

  set -e __dot_number_of_packages_installed

  return $response_code
end

function __dot_install_single
  if test (count $argv) -lt 3
    return 1
  end

  set -l package $argv[1]
  set -l repo $argv[2]
  set -l destination $argv[3]

  set_color yellow
  echo "Searching for $package..."
  set_color normal

  git ls-remote "$repo" > /dev/null ^/dev/null

  if test $status -ne 0
    set_color red
    echo "Repo not found: '$repo'"
    set_color normal

    return 128
  else
    set_color green
    echo "Installing $package..."
    set_color normal

    git clone "$repo" "$destination" > /dev/null ^/dev/null

    if test $status -ne 0
      set_color red
      echo "Installation of '$package' failed"
      set_color normal

      return 128
    else
      set -g __dot_number_of_packages_installed (math $__dot_number_of_packages_installed + 1)
    end
  end
end
