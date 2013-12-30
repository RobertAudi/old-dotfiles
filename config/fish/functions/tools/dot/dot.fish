function dot --description="dotfiles management tool"
  __dot_parse_options $argv

  if test $ARGC -gt 0
    set -l cmd $ARGV[1]
    set -e ARGV[1]
    set -gx ARGC (math $ARGC - 1)

    switch "$cmd"
    case "install"
      __dot_install

      set -l response_code $status
    case "update"
      __dot_update

      set -l response_code $status
    case "*"
      set_color red
      echo "dot: Invalid command '$cmd'"
      set_color normal

      set -l response_code 1
    end

    return $response_code
  else
    cd $DOTS
    set_color yellow
    echo ' '
    echo "git status:"
    set_color normal
    gs
  end
end
