progress() {
  if [[ $# -eq 0 ]]; then
    tput setaf 1
    echo "Internal error!"
    tput sgr0

    exit 1
  fi

  tput setaf 2
  echo -n "$1 ..."
  tput sgr0
}

succeed() {
  if [[ $# -eq 0 ]]; then
    tput setaf 1
    echo "Internal error!"
    tput sgr0

    exit 1
  fi

  tput setaf 2
  echo "$1"
  tput sgr0
}

fail() {
  if [[ $# -eq 0 ]]; then
    tput setaf 1
    echo "Internal error!"
    tput sgr0

    exit 1
  fi

  tput setaf 1
  echo "$1"
  tput sgr0
}

exit_if_needed() {
  [[ $# -eq 0 ]] && fail "Internal error!" && exit 1

  if (($1 > 0)); then
    fail " Failed"
    exit 1
  fi
}

exit_or_not() {
  [[ $# -eq 0 ]] && fail "Internal error!" && exit 1

  if (($1 == 0)); then
    succeed " Done"
  else
    fail " Failed"
    exit 1
  fi
}

is_installed() {
  [[ $# -eq 0 ]] && fail "Internal error!" && exit 1

  return $(type "$1" > /dev/null 2>&1)
}

randir() {
  cat /dev/urandom | env LC_CTYPE=C tr -cd "a-f0-9" | head -c 32
}
