if has("gui_macvim")
  set guifont=Inconsolata\ for\ Powerline:h14

  " Disable visual tabs
  set guioptions-=e

  " Use console dialogs instead of popups
  set guioptions+=c

  " Disable ALL scrollbars
  set guioptions-=r
  set guioptions-=L

  " Transparency
  set transparency=3

  " Toggle Fullscreen on Cmd + Enter
  nnoremap <D-CR> :set invfu<CR>

  " Start in Fullscreen
  autocmd GUIEnter * set fullscreen

  " NOTE: I don't use ! in commands intentionally
  function! DeleteAllBuffers()
    execute "wa"
    execute "silent Bonly"
    execute "bdelete"
  endfunction
  command! BOD call DeleteAllBuffers()
  nnoremap <silent> <C-Q> :call DeleteAllBuffers()<CR>
endif
