function unique --description 'Remove duplicates from environment variable'
  if test (count $argv) -eq 1
    set -l newvar
    set -l count 0
    for v in $$argv
      if contains -- $v $newvar
        inc count
      else
        set newvar $newvar $v
      end
    end

    set $argv $newvar
  else
    for a in $argv
      unique $a
    end
  end
end
