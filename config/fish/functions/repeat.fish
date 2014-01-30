function repeat
  if test (count $argv) -lt 2
    return 1
  end

  if test (count (echo -n "$argv[1]" | command grep -E "^\d+\$")) -ne 1
    return 1
  end

  set -l count 0
  set -l max $argv[1]
  set -e argv[1]

  while test $count -lt $max
    eval "$argv"

    set count (math $count + 1)
  end
end
