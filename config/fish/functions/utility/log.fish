function log
  __parse_options $argv

  set -l logfile (shlog log -g)

  if test (count $OPTV) -gt 0
    for opt in $OPTV
      switch $opt
      case "-t"
        command tail -f $logfile
      case "-c"
        # FIXME: Archive the log file before emptying it
        echo -n "" > $logfile
      end
    end
  else
    shlog log $argv
  end
end
