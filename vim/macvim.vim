if has("gui_macvim")
  set guifont=Inconsolata\ for\ Powerline

  " Disable visual tabs
  set guioptions-=e

  " Use console dialogs instead of popups
  set guioptions+=c

  " Disable ALL scrollbars
  set guioptions-=r
  set guioptions-=L

  " Toggle Fullscreen on Cmd + Enter
  nnoremap <D-CR> :set invfu<CR>

  " NOTE: I don't use ! in commands intentionally
  function! DeleteAllBuffers()
    exec "wa"
    exec "silent Bonly"
    exec "bd"
  endfunction
  command! BOD call DeleteAllBuffers()
endif
