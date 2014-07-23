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

# Copy path to current dir
alias pc="pwd | tr -d '\n' | pbcopy"

# ps aux | grep ...
alias psg="ps aux | grep"

# Copy my SSH key
alias cpssh="cat $HOME/.ssh/id_rsa.pub | pbcopy"

# Compress into tar.gz
alias zip="tar -czf"

 # OS X Quick Look
alias ql="qlmanage -p 2>/dev/null"

# open current dir in OS X Finder
alias oo="open ."

# Empty trash
alias emptytrash="rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
