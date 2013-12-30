function fish_user_key_bindings
  # Custom key bindings
  bind \cl "clear;countfiles;echo ' ';set_color yellow;echo \"List of dirs:\";echo \"-------------\";set_color normal;/bin/ls -GA;fish_prompt"
  bind \ei mvim
end
