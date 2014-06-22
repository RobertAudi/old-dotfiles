source $HOME/.base16.sh
source $HOME/.zshuery/zshuery.sh
source $HOME/.zsh.d/utility.zsh
load_defaults
load_aliases
load_completion $HOME/.zshuery/completion
load_correction

prompts '%{$fg_bold[green]%}$(prompt_pwd)%{$reset_color%} %{$fg[yellow]%}$(prompt_char "○")%{$reset_color%} '

# ENV variables
# -------------
# Editors and pager
export EDITOR="/usr/local/bin/vim"
export VISUAL="/usr/local/bin/mvim"
export SUDO_EDITOR="/usr/local/bin/vim"
export PAGER="/usr/local/bin/vimpager"
export MANPAGER="/usr/local/bin/vimpager"
export BROWSER="open"

# PATH
# ----
export MANPATH

if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# Put Homebrew's bin path before the system path
path=( /usr/local/bin $path )

# Use GNU utils instead of the OS X shit
path=( /usr/local/opt/coreutils/libexec/gnubin $path )
path=( /usr/local/opt/gnu-sed/libexec/gnubin $path )

# Custom bin dir has the highest priority
path=( $HOME/.bin $path )

# Remove duplicate entries from the PATH
typeset -U path

# MANPATH
# -------
manpath=( /usr/local/opt/coreutils/libexec/gnuman $manpath )
manpath=( /usr/local/opt/gnu-sed/libexec/gnuman $manpath )

# (Re-)Generate the list of manpages
export MANLIST=$HOME/.manlist
_manlistgen

# Setup run-help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/5.0.5/help

# Backward kill on directory delimiter
autoload -U select-word-style
select-word-style bash

# SCM Breeze
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

# ZSH Syntax Highlighting
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.1.1

# Custom shit
source $HOME/.zsh.d/zstyle.zsh
source $HOME/.zsh.d/bindings.zsh
source $HOME/.zsh.d/aliases.zsh
source $HOME/.zsh.d/functions.zsh
source $HOME/.zsh.d/completions.zsh

# manydots-magic
fpath=( $HOME/.zsh.d/manydots-magic $fpath )
autoload -Uz manydots-magic
manydots-magic

# Alias git to gh
eval "$(gh alias -s)"

# Fasd
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"

# Greeting!
source $HOME/.zsh.d/greeting.zsh
