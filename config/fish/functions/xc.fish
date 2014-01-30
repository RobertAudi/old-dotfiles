function xc
  set -l project (command ls | command grep ".xcodeproj")
  set -l workspace (command ls | command grep ".xcworkspace")

  if test (count $workspace) -gt 0
    open *.xcworkspace
    return
  end

  if test (count $project) -gt 0
    open *.xcodeproj
    return
  end

  set_color red
  echo "No XCode projects or workspaces found"
  set_color normal
  return 1
end
