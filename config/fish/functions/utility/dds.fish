function dds --description="Display directory stack"
  set_color yellow
  echo "Dir stack:"
  echo "----------"
  set_color blue
  dirs | awk '$1=$1' RS= OFS="\n"
  set_color normal
end
