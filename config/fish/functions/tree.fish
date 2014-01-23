function tree --description="List contents of directories in a tree-like format"
  set -l ignore "rhel.*.*.package|.git|.gem|*build*|*Pods*"
  set -l ignore "$ignore|*xc*|*mom*"
  command tree -CAFa -I "$ignore" --dirsfirst $argv
end
