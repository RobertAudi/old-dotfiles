function pcf --description="Copy to the clipboard the path to a file"
  set -l absolute_path (absolute "$argv[1]")

  if test "$absolute_path" != ""
    absolute "$argv[1]" | tr -d '\n' | pbcopy
  end
end
