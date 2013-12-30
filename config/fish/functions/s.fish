function s --description="Source the fish config"
  . $DOTS/home/.config/fish/config.fish

  for var in PATH fish_function_path
    unique $var
  end

  log message activity "User `$USER` manually sourced the fish config file"
end
