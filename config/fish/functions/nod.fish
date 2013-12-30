function nod --description="Count sub-directories"
  set -l num (/bin/ls -l $argv[1] | grep '^d' | wc -l | sed -e 's/^[ \t]*//')
  set_color yellow
  echo "There are $num sub-directories"
  set_color blue
  /bin/ls -l $argv[1] | awk '/^d/ {print $9}' | column
  echo ' '
  set_color normal
end
