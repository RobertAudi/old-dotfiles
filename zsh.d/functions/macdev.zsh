xx() {
  local proj=$(find . -maxdepth 1 -name "*.xcworkspace" | head -1)

  [[ -z "$proj" ]] && proj=$(find . -maxdepth 1 -name "*.xcodeproj" | head -1)

  if [[ -z "$proj" ]]; then
    echo "$fg[red]No XCode project found!$reset_color"
    return 1
  fi

  open $proj
}

aa() {
  if (( $(command find /Applications /opt/homebrew-cask/Caskroom -type d -maxdepth 3 -name "AppCode.app" -print -quit | wc -l) == 0 )); then
    echo "$fg[red]AppCode is not installed!$reset_color"
    return 1
  fi

  local proj=$(find . -maxdepth 1 -name "*.xcworkspace" | head -1)

  [[ -z "$proj" ]] && proj=$(find . -maxdepth 1 -name "*.xcodeproj" | head -1)

  if [[ -z "$proj" ]]; then
    echo "$fg[red]No XCode project found!$reset_color"
    return 1
  fi

  open -a "AppCode" $proj
}
