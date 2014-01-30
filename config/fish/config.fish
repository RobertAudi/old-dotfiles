# Base16 Railscast for the shell
eval sh $HOME/.base16-railscasts.dark.sh

. $HOME/.dotfiles/config/fish/config.private.fish

# ENV variables
# -------------
# Editors and pager
set -gx EDITOR vim
set -gx VISUAL mvim
set -gx PAGER vimpager

# Initialise the OLDPWD variable so that
# the custom cd function works properly
set -x OLDPWD $HOME

# Cache important directories in ENV variables
set -gx DOTS "$HOME/.dotfiles"
set -gx PDOTS "$HOME/.dotfiles.pub"
set -gx USER_TMPDIR "$HOME/tmp"

# List the dot packages to use
set -gx DOT_PACKAGES "chrubygems" "gish"

# NVim
set -gx NVIM_HOME "$DOTS/home/notational"

# Enable dev mode
set -gx DEV_MODE "debug"

# Make autojump case-insensitive
set -gx AUTOJUMP_IGNORE_CASE 1

# PATH
# ----
# Add the fish bin to the $PATH
set fish_user_paths $HOME/bin $fish_user_paths

# Add Postgres.app's bin dir to the path
set fish_user_paths /Applications/Postgres.app/Contents/MacOS/bin $fish_user_paths

# Add npm's bin dir to the path
set fish_user_paths /usr/local/share/npm/bin $fish_user_paths

# Add homebrew's bin dir before the system ones
set -gx PATH /usr/local/bin $PATH

# Function PATH
# -------------
# Apply the Fish theme
set fish_function_path $HOME/.config/fish/theme $fish_function_path

# Load overriden commands
set fish_function_path $HOME/.config/fish/functions/overrides $fish_function_path

# Utility functions
set fish_function_path $HOME/.config/fish/functions/utility $fish_function_path

# Debug functions
set fish_function_path $HOME/.config/fish/functions/debug $fish_function_path

# Hooks
set fish_function_path $HOME/.config/fish/functions/hooks $fish_function_path

# Load shit that changes the Fish shell
set fish_function_path $HOME/.config/fish/load $fish_function_path

for dir in (/bin/ls -d $HOME/.config/fish/functions/tools/*/)
  set -l dir (echo -n "$dir" | sed 's/\/\$//')

  set fish_function_path $dir $fish_function_path
end

# chrubygems
if test -f "$HOME/.chrubygems/init.fish"
  . $HOME/.chrubygems/init.fish
  set -gx CHGEMS_GLOBAL_GEMS "$HOME/.chgems_global_gems"

  # Default ruby
  chruby ruby-2.0.0-p353 > /dev/null
else
  log "chrubygems not installed. Using system ruby instead."
end

if test -f "$HOME/.gish/init.fish"
  . $HOME/.gish/init.fish
else
  log "gish not installed."
end

# Remove duplicate entries in different variables
for var in PATH fish_function_path
  unique $var
end

# Because fish hooks are broken...
__ruby_motion_hook

# Alias git to hub
eval (hub alias -s)
