function raked --description="rake in debug mode"
  command bundle exec rake debug=1 NSZombieEnabled=YES MallocStackLogging=1
end
