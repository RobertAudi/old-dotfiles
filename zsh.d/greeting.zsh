aziz_light() {
  echo "\n"
  figlet "Aziz, Light!" | toilet -f term -F gay
  echo "\n"
}

greeting() {
  if [[ $already_sourced_once == 1 ]]; then
    return
  fi

  aziz_light
  count_files
  list_of_files

  already_sourced_once=1
}

greeting
