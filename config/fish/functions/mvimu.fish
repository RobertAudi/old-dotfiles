function mvimu --description="Edit all modified and untracked files in MacVim"
  set -l files (echo (git ls-files -m) (git ls-files --other --exclude-standard))
  mvim -c "EM $gituf"
end
