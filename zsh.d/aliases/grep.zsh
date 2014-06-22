# Return appropriate options for grep
grepopts() {
  # Snarf the output of `grep --help` into a variable
  local grephelp=$(grep --help 2>/dev/null)

  # Start collecting available options
  local -a grepopts

  # Add option to ignore binary files
  grepopts=("${grepopts[@]}" '-I')

  # Exclude some VCS files
    grepopts=("${grepopts[@]}" '--exclude=.git{,ignore,modules}')

  # Exclude some VCS dirs
  grepopts=("${grepopts[@]}" '--exclude-dir=.{cvs,git,hg,svn}')

  # Add --color=auto to the options
  grepopts=("${grepopts[@]}" '--color=auto')

  # Print the options as a single string, space-delimited
  printf %s "${grepopts[*]}"
}

# Alias grep with those options
alias grep="grep $(grepopts)"

# Unset helper function
unset -f grepopts
