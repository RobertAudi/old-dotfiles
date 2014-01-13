function gem --description="chgems aware gem"
  set -l global_install "false"

  if test (count $argv) -gt 1
    if test "$argv[1]" = "install"
      if test (count (echo "$argv[2]" | command grep -E "^-{1,2}g")) -gt 0
        set -e argv[2]
        set global_install "true"
      end
    end
  end

  if test $global_install = "true"
    set -l old_gem_home (echo "$GEM_HOME" | command sed -E "s/\/\.gem.*//")
    chgems "$HOME" > /dev/null

    command gem $argv

    chgems "$old_gem_home" > /dev/null
  else
    command gem $argv
  end
end
