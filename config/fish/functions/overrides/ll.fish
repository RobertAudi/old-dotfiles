function ll
  set -l old_clicolor_force $CLICOLOR_FORCE
  set -gx CLICOLOR_FORCE 1
  command ls -lG $argv | awk "{print \$9}" | tail +2
  set -gx CLICOLOR_FORCE $old_clicolor_force
end
