function cv --description="Got into a directory and open MacVim"
  cd $argv[1]
  eval $VISUAL
end
