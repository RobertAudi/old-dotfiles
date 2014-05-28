# Better ls output
alias ls="ls -pF --color=auto"

# Be verbose
alias mv="mv -iv"
alias cp="cp -iv"
alias chmod="chmod -v"
alias chown="chown -v"
alias mkdir="mkdir -vp"

# grep family colors
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Replace the sudo prompt and add some color to it
alias sudo="sudo -p \"$fg_bold[red][sudo] Password:$fg[default]\" "

# Always ping 3 times
alias ping="ping -c 3"

# vi is Vim
alias vi="/usr/local/Cellar/macvim/HEAD/MacVim.app/Contents/MacOS/Vim"

# MacVim is Vim
alias vim="mvim"

# Fix a tmux "bug"
alias tmux="EDITOR= VISUAL= tmux"
