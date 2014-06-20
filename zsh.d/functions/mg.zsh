mg() {
  local repo

  if ! repo=$(git rev-parse --git-dir | xargs realpath); then
    echo "$fg[red]You are not in a git repo!$reset_color"
    return 1
  fi

  local rootdir=${repo%/*}
  local dbdir=$(find $rootdir -type d -name "*.xcdatamodel" | head -1 | xargs realpath)

  if [[ -z "$dbdir" ]]; then
    echo "$fg[red]No data model found!$reset_color"
    return 1
  fi

  local xcprojname=$(find $rootdir -iname "*.xcodeproj" -type d -not -path "*Pods/*" | head -1 | xargs basename)
  local projname=${xcprojname%.*}

  if [[ ! -d $projname ]]; then
    echo "$fg[red]Project directory not found!$reset_color"
    return 1
  fi

  local humandir=$(find $rootdir -type d -iname "models" | head -1 | xargs realpath)
  local machinedir=$(find $rootdir -type d -iname "generated" | head -1 | xargs realpath)

  [[ -z "$humandir" ]] && humandir="${rootdir%%/}/$projname/models"
  [[ -z "$machinedir" ]] && machinedir="${rootdir%%/}/$projname/models/generated"

  if type "mogenerator" > /dev/null 2>&1; then
    [[ ! -d $humandir   ]] && command mkdir $humandir   > /dev/null
    [[ ! -d $machinedir ]] && command mkdir $machinedir > /dev/null

    mogenerator -m $dbdir --template-var arc=true -M $machinedir -H $humandir
  else
    echo "$fg[red]mogenerator is not found!$reset_color"
    return 1
  fi
}
