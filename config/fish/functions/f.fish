function f --description="Find sub-directories"
  set -l results (find . -type d -iname "*$argv[1]*")

  if test (count $results) -eq 1
    # Cache the absolute path of the single match
    set -l perfect_match (absolutedir "$results")

    # Display the single match and highlight the matching part
    echo $perfect_match | grep -i "\/[^\/]*$argv[1][^\/]*\$"

    # Blank line...
    echo ' '

    # Copy the single match to the system clipboard...
    echo $perfect_match | command tr -d '\n' | command pbcopy

    # ...and notify the user
    set_color green
    echo "The path to the matched directory was copied to your clipboard!"
    set_color normal
  else
    # Display all matches and highlight the matching parts
    for result in $results
      echo (absolutedir "$result") | grep -i "\/[^\/]*$argv[1][^\/]*\$"
    end
  end
end
