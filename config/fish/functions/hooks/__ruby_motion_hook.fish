function __ruby_motion_hook --on-event fish_prompt
  set -l rubymotion_function_path $HOME/.config/fish/functions/rubymotion

  if test (count (pwd | command grep "RubyMotion")) -gt 0
    if not contains $rubymotion_function_path $fish_function_path
      set fish_function_path $rubymotion_function_path $fish_function_path
    end
  else
    if contains $rubymotion_function_path $fish_function_path
      __remove_fish_function_path $rubymotion_function_path

      set -l rubymotion_functions (command ls -lG $HOME/.config/fish/functions/rubymotion | awk "{print \$9}" | tail +2 | sed "s/\.fish//g")

      for rmfunc in $rubymotion_functions
        functions -e $rmfunc
      end
    end
  end
end
