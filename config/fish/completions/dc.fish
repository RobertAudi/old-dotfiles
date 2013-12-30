complete -c dc --authoritative -f
for folder in (pwd | tr '/' '\n')
  complete -c dc -a "$folder"
end
