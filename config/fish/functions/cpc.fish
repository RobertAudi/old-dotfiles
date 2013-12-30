function cpc --description="Copy the last command to the clipboard"
  if test (count (history | tail -1 | tr -d '\n')) -eq 1
    history | head -1 | sed -e 's/\(\'"\)/\\\1/g' | awk '{q=p;p=$0}NR>1{print q}END{ORS = ""; print p}' | pbcopy

    set_color green
    echo "The last command was copied to your clipboard"
    set_color normal
  else
    set_color red
    echo "Your history is empty..."
    set_color normal
    return 1
  end
end
