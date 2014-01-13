function fish_greeting
  if test -z $NEW_SESSION_CMD
    __aziz_light

    test (count (tty | command grep "ttys000")) -eq 1
    and gol --no-clear
  else
    test -n "$TILE_WINDOW"
    and test $TILE_WINDOW -eq 1
    and gol --no-clear > /dev/null
    and set -e TILE_WINDOW

    __aziz_light

    eval $NEW_SESSION_CMD

    set -e NEW_SESSION_CMD
  end

  log "User `$USER` opened a new terminal session"
end

function __aziz_light
  echo " "
  echo " "
  figlet "Aziz, Light!" | toilet -f term -F gay
  echo " "
  echo " "
end
