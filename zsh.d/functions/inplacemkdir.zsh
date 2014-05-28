# Create directory under cursor or the selected area
inplaceMkDirs() {
  # Press ctrl-xM to create the directory under the cursor or the selected area.
  # To select an area press ctrl-@ or ctrl-space and use the cursor.
  # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
  # directory does not exist yet -> press ctrl-XM and problem solved
  local PATHTOMKDIR
  if ((REGION_ACTIVE==1)); then
    local F=$MARK T=$CURSOR
    if [[ $F -gt $T ]]; then
      F=${CURSOR}
      T=${MARK}
    fi
    # get marked area from buffer and eliminate whitespace
    PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
    PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
  else
    local bufwords iword
    bufwords=(${(z)LBUFFER})
    iword=${#bufwords}
    bufwords=(${(z)BUFFER})
    PATHTOMKDIR="${(Q)bufwords[iword]}"
  fi
  [[ -z "${PATHTOMKDIR}" ]] && return 1
  PATHTOMKDIR=${~PATHTOMKDIR}
  if [[ -e "${PATHTOMKDIR}" ]]; then
    zle -M " path already exists, doing nothing"
  else
    zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
    zle end-of-line
  fi
}

# mkdir -p <dir> from string under cursor or marked area
zle -N inplaceMkDirs
