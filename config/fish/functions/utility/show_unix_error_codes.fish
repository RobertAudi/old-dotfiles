function show_unix_error_codes
  perl -le 'print $!+0, "\t", $!++ for 0..127'
end
