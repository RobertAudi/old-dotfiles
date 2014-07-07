count_files() {
  local number_of_files=$(command ls -A $1 | wc -l | sed -e 's/^[ \t]*//')
  echo "$fg[yellow]There are $number_of_files files in this directory.$reset_color"
}

list_of_files() {
  echo "$fg[yellow]List of files:$reset_color"
  echo "$fg[yellow]--------------$reset_color"
  command ls -pFA --color=auto
}

prompt_pwd() {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "~"
  else
    echo "%1C"
  fi
}

_manlistgen() {
  man -k . | sed "/^$/d" | sed -E "s/^[ \t]*//g" | sed -E "s/- .*//g" | sed -E "s/, /\n/g" | sed -E "s/^[^a-z0-9].*//g" | sed "/^$/d" | sed "s/(.*//g" | sort | uniq > $MANLIST
}

envup() {
  if [[ -f ".env" ]]; then
    export $(cat .env)
  else
    echo "No .env file found" 1>&2
    return 1
  fi
}

envdown() {
  if [[ -f ".env" ]]; then
    unset $(cat .env | sed "s/=.*//g")
  else
    echo "No .env file found" 1>&2
    return 1
  fi
}
