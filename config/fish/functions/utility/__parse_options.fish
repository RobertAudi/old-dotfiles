function __parse_options --description="Parse options"
  set -l argc (count $argv)
  set -l optc 0

  if test $argc -eq 0
    set -gx OPTC $optc
    set -gx ARGC $argc

    return
  end

  set -l arguments $argv
  set -l options
  set -l counter 1
  while test $counter -le $argc
    if test (count (echo -n "$arguments[$counter]" | command grep -E "^-{1,2}\w+(-\w+)*\$")) -eq 1
      set options $options $arguments[$counter]

      set -e arguments[$counter]

      set argc (math $argc - 1)

      if test $counter -gt 1
        set counter (math $counter - 1)
      end
    else
      set counter (math $counter + 1)
    end
  end

  set -gx OPTC (count $options)
  set -gx OPTV $options
  set -gx ARGC $argc
  set -gx ARGV $arguments
end
