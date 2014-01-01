function countdir --description="Count sub-directories"
  set -l num (/bin/ls -l $argv[1] | grep '^d' | wc -l | sed -e 's/^[ \t]*//')
  set_color yellow
  echo "There are $num sub-directories"
  set_color normal
end
