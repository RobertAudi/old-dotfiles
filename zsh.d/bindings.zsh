bindkey -e

bindkey '[C' forward-word
bindkey '[D' backward-word

# make enter accept and Ctrl-O add space in menu select
bindkey -M menuselect "^M" accept-line
bindkey -M menuselect "^O" accept-line
bindkey "^O" accept-line

# Enable globbing in incremental search
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
