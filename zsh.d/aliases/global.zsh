# grep
alias -g "?"="| grep"

# convert string to uppercase
alias -g ":upper"=" | tr \"[:lower:]\" \"[:upper:]\""
# convert string to lowercase
alias -g ":lower"=" | tr \"[:upper:]\" \"[:lower:]\""

# Faster copying
alias -g ":c"=" | pbcopy"

# STFU!!
alias -g ":n"="> /dev/null 2>&1"
