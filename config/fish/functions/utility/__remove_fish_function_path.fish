function __remove_fish_function_path
  set -l new_fish_function_path

  for fp in $fish_function_path
    if test $fp != $argv
      set new_fish_function_path $new_fish_function_path $fp
    end
  end

  set fish_function_path $new_fish_function_path
end
