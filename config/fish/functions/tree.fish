function tree --description="List contents of directories in a tree-like format"
  /usr/local/bin/tree -CAFa -I 'rhel.*.*.package|.git' --dirsfirst $argv
end
