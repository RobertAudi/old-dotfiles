function dtree --description="List directories recursively in a tree-like format"
  /usr/local/bin/tree -dCAFa -I 'rhel.*.*.package|.git' --dirsfirst $argv
end
