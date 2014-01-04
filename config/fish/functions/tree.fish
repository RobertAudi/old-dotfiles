function tree --description="List contents of directories in a tree-like format"
  command tree -CAFa -I 'rhel.*.*.package|.git|.gem' --dirsfirst $argv
end
