autoload -U colors && colors

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Backward kill on directory delimiter
autoload -U select-word-style
select-word-style bash

# Setup run-help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/5.0.5/help

fpath=( $HOME $fpath )

source $HOME/.base16.sh
source $HOME/.zsh.d/utility.zsh

# ENV variables
# -------------
# Editors and pager
export EDITOR="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"
export VISUAL="/usr/local/bin/mvim"
export SUDO_EDITOR="/usr/local/opt/macvim/MacVim.app/Contents/MacOS/Vim"
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

# Go(at) shit
export GOPATH="$HOME/DevShit/go-shit"
path=( $GOPATH/bin $path )

# Remove duplicate entries from the PATH
typeset -U path

# MANPATH
# -------
manpath=( /usr/local/opt/coreutils/libexec/gnuman $manpath )
manpath=( /usr/local/opt/gnu-sed/libexec/gnuman $manpath )

# (Re-)Generate the list of manpages
export MANLIST=$HOME/.manlist
_manlistgen

# ZOMGit
source /Users/rob/.gem/ruby/2.1.1/gems/zomgit-0.0.2/share/zomgit.zsh

# Geez!
source $HOME/.geez/geez.zsh

# ZSH Syntax Highlighting
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.1.1

# Custom shit
source $HOME/.zsh.d/defaults.zsh
source $HOME/.zsh.d/prompt.zsh
source $HOME/.zsh.d/aliases.zsh
source $HOME/.zsh.d/functions.zsh
source $HOME/.zsh.d/completions.zsh
source $HOME/.zsh.d/bindings.zsh

# manydots-magic
fpath=( $HOME/.zsh.d/manydots-magic $fpath )
autoload -Uz manydots-magic
manydots-magic

# Alias git to gh
eval "$(gh alias -s)"

# Fasd
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Greeting!
source $HOME/.zsh.d/greeting.zsh
