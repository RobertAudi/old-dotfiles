k() {
  ps -ef | sed 1d | selecta | awk '{print $2}' | xargs kill -${1:-9}
}

m() {
  [[ -f $MANLIST ]] || _manlistgen

  cat $MANLIST | selecta | xargs man
}
