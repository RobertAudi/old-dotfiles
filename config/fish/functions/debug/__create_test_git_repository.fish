function __create_test_git_repository --description="Create a test git repository"
  set -l test_git_repo "$USER_TMPDIR/foo"
  if test -d $test_git_repo
    rm -rf $test_git_repo > /dev/null
    and log message info "The test git repo in $test_git_repo was removed"
  end

  mcd $test_git_repo > /dev/null
  and git init . > /dev/null
  and echo "This is a test git repository" > README.md
  and git add . > /dev/null
  and git commit -m "Initial commit" > /dev/null
  and pwd | pbcopy
  and cd - > /dev/null
  and set test_git_repo (pbpaste)
  and log message activity "User `$USER` created a test git repository in $test_git_repo"
  and set_color green
  and echo "New test git repository created in $test_git_repo (path copied in your clipboard)"
  and set_color normal
end
