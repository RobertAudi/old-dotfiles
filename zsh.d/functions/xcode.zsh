xx() {
  local proj=$(find . -maxdepth 1 -name "*.xcworkspace" | head -1)

  [[ -z "$proj" ]] && proj=$(find . -maxdepth 1 -name "*.xcodeproj" | head -1)

  if [[ -z "$proj" ]]; then
    echo "$fg[red]No XCode project found!$reset_color"
    return 1
  fi

  open $proj
}
