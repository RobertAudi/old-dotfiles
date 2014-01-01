function dtree --description="List directories recursively in a tree-like format"
  command tree -dCAFa -I 'rhel.*.*.package|.git' --dirsfirst $argv
end
