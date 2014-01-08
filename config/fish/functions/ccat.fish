function ccat --description="Colored cat"
  # IMPROVE: Check for the pygmentize command
  # IMPROVE: Check for $argv maybe
  command pygmentize -g $argv
end
