function countfiles
  set -l num (/bin/ls -A $argv[1] | wc -l | sed -e 's/^[ \t]*//')
  set_color yellow
  echo "There are $num files in this directory."
  set_color normal
end
