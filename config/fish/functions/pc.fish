function pc --description="Copy the path of the working directory to the clipboard"
  command pwd | command tr -d '\n' | command pbcopy
end
