function cleanup --description="Delete all .DS_Store files recursively"
  find . -name '*.DS_Store' -type f -ls -delete
  and log message activity "User `$USER` removed all the .DS_Store files in $PWD recursively"
end
