# Reload the zsh config
alias s="source $HOME/.zshrc"

# Make file executable
alias ax="chmod a+x"

# Faster alternate dir switching
alias -- -="cd -"

# Find in /
alias sfind="sudo find / -iname"

# Sudo vim
alias svim="sudoedit"

# vimpager
alias vp="vimpager"

# Unarchive using dtrx
alias x="dtrx"

# Copy last command
alias cpc="history | tail -1 | sed -e \"s/^[ \t]*//\" | cut -d' ' -f2- | sed -e \"s/^[ \t]*//\" | pbcopy"

# Directory tree
alias dtree="command tree -dCAFa -I 'rhel.*.*.package|.git|.gem' --dirsfirst"

# z == j
alias z="j"

# open current dir in file manager
alias oo="open ."

# Copy path to current dir
alias pc="pwd | tr -d '\n' | pbcopy"

# ps aux | grep ...
alias psg="ps aux | grep"

# Check the internet connection
alias "check-internet"="ping www.google.com"

# Generate ctags
alias "gen-ctags"="ctags -R --exclude=.git --exclude=log *"

# Real IP
alias "real-ip"="curl http://myexternalip.com/raw"

# todo.sh
alias t="todo.sh"

# Copy my SSH key
alias cpssh="cat $HOME/.ssh/id_rsa.pub | pbcopy"
