ruby-build() {
  local rubies_home="$HOME/.rubies"

  if [[ ! -d $rubies_home ]]; then
    /bin/mkdir -p $rubies_home > /dev/null
  fi

  local dest=$rubies_home/$1

  command ruby-build $1 $dest
}
