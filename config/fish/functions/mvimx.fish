function mvimx --description="Open a new executable file in MacVim"
  touch $argv[1]
  chmod a+x $argv[1]
  mvim $argv[1]
end
