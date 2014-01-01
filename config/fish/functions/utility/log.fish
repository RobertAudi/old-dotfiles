#
# Add the following commands:
# - count
#
# Add the short form of the --all option `-a`
#
function log --description="Log a message to a file"
  __log_setup

  set -l argc (count $argv)

  if test $argc -lt 1
    log message error "Tried to use the log command with missing arguments"
    return 1
  end

  set -l arguments $argv
  set -l options

  set -l counter 1
  set -l max (count $arguments)

  while test $counter -le $max
    test (count (echo $arguments[$counter] | command grep -E "^--?[[:alpha:]]+(-?[[:alpha:]])*\$")) -eq 1
    and set options $options $arguments[$counter]
    and set -e arguments[$counter]
    and set argc (math $argc - 1)
    and set max (math $max - 1)
    set counter (math $counter + 1)
  end

  test $argc -ge 1
  and set -l action $arguments[1]
  and set -e arguments[1]
  and set argc (math $argc - 1)

  switch $action
    case "message"
      test (count $options) -gt 0
      and log message error "Tried to use the log command with invalid options"
      and return 1

      set -l level

      if test $argc -gt 1
        test (count (echo $arguments[1] | grep -E "^[[:alpha:]]+\$")) -eq 0
        and log message error "Tried to use the log command with an invalid log level"
        and return 1

        set level (echo -n $arguments[1] | tr '[:lower:]' '[:upper:]')
        and set -e arguments[1]
        and set argc (math $argc - 1)
      else
        log message error "Tried to use the log a message without providing a log level"
        and return 1
      end

      set -l message (cat /dev/null)

      test (count $arguments) -gt 0
      and test (count (echo $arguments[1] | command grep "^\$")) -eq 0
      and set message "$level: $arguments"

      __log_message $message
    case "show"
      test (count $options) -gt 0
      and test (count (echo $options | command grep -E "\--all")) -lt (count $options)
      and log message error "Tried to use the log command with invalid options"
      and return 1

      test $argc -gt 2
      and log message error "Tried to show logs but provided too many arguments"
      and return 1

      __log_show $arguments $options
    case "remove"
      set -l all_option_count (count (echo $options | command grep -E "\--all"))
      test (count $options) -gt 0
      and test $all_option_count -lt (count $options)
      and log message error "Tried to use the log command with invalid options"
      and return 1

      if test $all_option_count -eq 1
        read --local --prompt="set_color yellow; echo 'Are you sure that you want to remove ALL log files? (Type y to confirm)'; set_color normal" should_all_the_logs_be_removed

        test (count (echo $should_all_the_logs_be_removed | grep "^[yY].*\$")) -eq 1
        and set -l log_files (/bin/ls $USER_LOG_DIRECTORY/*.log)
        and set -l number_of_log_files (count $log_files)
        and /bin/rm -f $log_files
        and set_color green
        and echo "ALL log files removed ($number_of_log_files total)"
        and set_color normal
        and return

        set_color yellow
        and echo "Removal cancelled"
        and set_color normal
        and return
      else
        set -l number_of_old_log_files (count (/bin/ls $USER_LOG_DIRECTORY/user-*))
        read --local --prompt="set_color yellow; echo 'There are $number_of_old_log_files old log files. How many do you want to remove?'; set_color normal" number_of_logs_to_remove

        if test (count (echo $number_of_logs_to_remove | grep "^[1-9][0-9]*\$")) -eq 1
          if test $number_of_old_log_files -ge $number_of_logs_to_remove
            /bin/rm -f (/bin/ls -tr $USER_LOG_DIRECTORY/user-*.log | head "-$number_of_logs_to_remove")
            and set_color green
            and echo "Oldest $number_of_logs_to_remove log files removed"
            and set_color normal
            and return
          else
            set_color yellow
            and echo "You specified a number that is greater than the total number of old log files"
            and echo "Removing all old log files..."
            and set_color normal
            and set -l log_files (/bin/ls $USER_LOG_DIRECTORY/user-*.log)
            and set -l number_of_log_files (count $log_files)
            and /bin/rm -f $log_files
            and set_color green
            and echo "All old log files removed ($number_of_log_files total)"
            and set_color normal
            and return
          end
        end
      else
        set_color red
        and echo "You need to enter a number"
        and set_color yellow
        and echo "Removal cancelled"
        and set_color normal
        and return 1
      end
  end
end

function __log_setup
  test -z $USER_LOG_MAX_FILE_SIZE
  and set -gx USER_LOG_MAX_FILE_SIZE 10000

  test -z $USER_LOG_VIEW_SIZE
  and set -gx USER_LOG_VIEW_SIZE 50

  test -z $USER_LOG_DIRECTORY
  and set -gx USER_LOG_DIRECTORY "$HOME/.logs"

  set -gx USER_LOG_FILE "$USER_LOG_DIRECTORY/user.log"
end

function __log_message
  if test (count $argv) -eq 0
    __log_message "ERROR: Tried to log a message without a message"
    return 1
  end

  if test -d $USER_LOG_DIRECTORY
    test -f $USER_LOG_FILE
    and test (wc -l $USER_LOG_FILE | sed 's/[^0-9]//g') -ge $USER_LOG_MAX_FILE_SIZE
    and set -l timestamp (ruby -e "print Time.now.to_i")
    and /bin/mv $USER_LOG_FILE "$USER_LOG_DIRECTORY/user-$timestamp.log"
  else
    /bin/mkdir -p $USER_LOG_DIRECTORY
  end

  command touch $USER_LOG_FILE

  set -l log_time (ruby -e "print Time.now")
  and echo "[$log_time] $argv" >> $USER_LOG_FILE
end

function __log_show
  set -l argc (count $argv)

  set -l argv_cache $argv
  set -l arguments
  set -l options

  set -l min 1
  while test $argc -ge $min
    test (count (echo $argv_cache[$argc] | command grep "\--?")) -eq 1
    and set options $argv_cache[$argc] $options
    and set -e argv_cache[$argc]
    and set argc (math $argc - 1)
    and continue

    break
  end

  set arguments $argv_cache
  and set -e argv_cache

  set -l counter 1
  set -l tmp
  while test $counter -le $argc
    if test (count (echo $arguments[$counter] | command grep "^\$" )) -eq 1
      set tmp $tmp (cat /dev/null)
    else
      set tmp $tmp $arguments[$counter]
    end

    set counter (math $counter + 1)
  end

  set arguments $tmp
  and set -e tmp

  set argc (count $arguments)

  set -l level
  set -l number

  switch $argc
    case 0
      set level (cat /dev/null)
      set number (cat /dev/null)
    case 1
      if test (count (echo $arguments[1] | command grep -E "^[1-9]\d*\$")) -eq 1
        set level (cat /dev/null)
        set number $arguments[1]
      else if test (count (echo $arguments[1] | command grep -E "^[[:alpha:]]\$")) -eq 1
        set level $arguments[1]
        set number (cat /dev/null)
      end
    case 2
      if test (count (echo $arguments[1] | command grep -E "^[1-9]\d*\$")) -eq 1
        test (count (echo $arguments[2] | command grep -E "^[[:alpha:]]+\$")) -eq 1
        and set level $arguments[2]
        and set number $arguments[1]
      else if test (count (echo $arguments[1] | command grep -E "^[[:alpha:]]+\$")) -eq 1
        test (count (echo $arguments[2] | command grep -E "^[1-9]\d*\$")) -eq 1
        and set level $arguments[1]
        and set number $arguments[2]
      else
        log message error "Tried to show logs but supplied invalid arguments"
        and return 1
      end
  end

  set -e arguments
  set -l all_option_count (count (echo $options | command grep -E "\--all"))

  test $all_option_count -eq 1
  and test -n $number
  and log message error "Tried to show all logs but supplied a number at the same time"
  and return 1

  if test -n $level
    test $all_option_count -eq 1
    and cat $USER_LOG_FILE | command grep "$level:"
    and log message info "User `$USER` looked at all the logs"
    and return

    test -n $number
    and tail "-$number" $USER_LOG_FILE | command grep "$level:"
    and log message info "User `$USER` looked at the last $number logs"
    and return

    test -n $USER_LOG_VIEW_SIZE
    and tail "-$USER_LOG_VIEW_SIZE" $USER_LOG_FILE | command grep "$level:"
    and log message info "User `$USER` looked at the last $USER_LOG_VIEW_SIZE logs"
    and return
  else
    test $all_option_count -eq 1
    and cat $USER_LOG_FILE
    and log message info "User `$USER` looked at all the logs"
    and return

    test -n $number
    and tail "-$number" $USER_LOG_FILE
    and log message info "User `$USER` looked at the last $number logs"
    and return

    test -n $USER_LOG_VIEW_SIZE
    and tail "-$USER_LOG_VIEW_SIZE" $USER_LOG_FILE
    and log message info "User `$USER` looked at the last $USER_LOG_VIEW_SIZE logs"
    and return
  end
end
