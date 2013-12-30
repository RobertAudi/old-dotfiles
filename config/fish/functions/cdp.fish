function cdp --description="Go to the directory in the clipboard"
  cd (pbpaste)
  echo " " | pbcopy
end
