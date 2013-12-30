# FIXME: GET RID OF THAT SHIT AND USE `dot` instead!
function pdot --description="Go to the public dotfiles directory"
  cd $PDOTS
  set_color yellow
  echo ' '
  echo "git status:"
  set_color normal
  gs
end
