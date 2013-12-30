function psg --description="pipe ps to grep"
  ps aux | grep $argv
end
