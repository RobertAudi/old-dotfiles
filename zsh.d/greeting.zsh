greeting() {
  if [[ $already_sourced_once == 1 ]]; then
    return
  fi

  count_files
  list_of_files

  already_sourced_once=1
}

greeting
