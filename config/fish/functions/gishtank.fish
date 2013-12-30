function gishtank --description="Go to the gishtank directory"
  cd $GISHTANK_DIR

  set_color yellow
  echo " "
  echo "git status:"
  set_color normal
  gs
end
