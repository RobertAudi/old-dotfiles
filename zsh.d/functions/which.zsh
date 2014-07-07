w() {
  local option=""
  local prog=""

  case "$#" in
    "0")
      echo "$fg[red]w: Missing argument!$reset_color"
      return 1
      ;;
    "1")
      if [[ "$1" == "-1" ]]; then
        echo "$fg[red]w: Invalid arguments!$reset_color"
        return 1
      fi

      option="-a"
      cmd="$1"
      ;;
    "2")
      if [[ "$1" == "-1" ]]; then
        cmd="$2"
      elif [[ "$2" == "-1" ]]; then
        cmd="$1"
      else
        echo "$fg[red]w: Invalid arguments!$reset_color"
        return 1
      fi
      ;;
    *)
      echo "$fg[red]w: Too many arguments!$reset_color"
      return 1
      ;;
  esac

  builtin which "$option" "$cmd"
}
