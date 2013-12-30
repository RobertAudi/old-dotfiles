function mkt --description="Create a file in a directory that doesn't exist yet"
  if test (count $argv) -eq 0
    set_color red
    echo "You need to supply a file to create..."
    set_color normal
    return 1
  end

  for arg in $argv
    if test -d $arg
      set_color red
      echo "A directory with the same name already exists..."
      set_color normal
      continue
    end

    if test -f $arg
      set_color red
      echo "The file $arg already exists..."
      set_color normal
      continue
    end

    if test (count (echo $arg | /usr/bin/grep "/")) -eq 0
      touch $arg

      set_color green
      echo "Created new file: $arg"
      set_color normal
    else
      __mkt_create_directories (echo $arg | sed 's/\(\(.*\)\/\).*/\2/g' | tr '/' '\n')
      if test $status -eq 0
        touch $arg

        set_color green
        echo "Created new file: $arg"
        set_color normal
      end
    end
  end
end

function __mkt_create_directories
  if test (count $argv) -eq 0
    return 1
  end

  set -l full_path ""

  for arg in $argv
    set full_path "$full_path$arg"
    if test -f $full_path
      set_color red
      echo "There is already a file named $full_path..."
      set_color normal
      return 1
    end

    if not test -d $full_path
      mkdir $full_path > /dev/null
      set_color green
      echo "Created new directory: $full_path"
      set_color normal
    end

    set full_path "$full_path/"
  end

  return 0
end
