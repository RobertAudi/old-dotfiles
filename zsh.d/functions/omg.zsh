export ORIG_GEM_PATH=${GEM_PATH:-}
export ORIG_GEM_HOME=${GEM_HOME:-}
export ORIG_PATH=${PATH}

omg() {
  if [[ "$1" =~ "^h(elp)?\$" ]]; then
    echo "Usage: omg [h|help|r|reset]"
  elif [[ "$1" =~ "^r(eset)?\$" ]]; then
    if [[ -z "$ORIG_GEM_HOME" ]]; then
      unset GEM_HOME
    else
      GEM_HOME="$ORIG_GEM_HOME"
    fi

    GEM_PATH="$ORIG_GEM_PATH"
    PATH="$ORIG_PATH"

    echo "$fg[green]Gem environment reset!$reset_color"
  else
    ruby_engine="$(ruby -e "print defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'")"
    ruby_version="$(ruby -e "print RUBY_VERSION")"

    export GEM_HOME="$PWD/.gem/$ruby_engine/$ruby_version"
    export GEM_PATH="$GEM_HOME:$ORIG_GEM_PATH"
    export PATH="$GEM_HOME/bin:$ORIG_PATH"

    echo "$fg[green]Gem isolation complete!$reset_color"
  fi
}
