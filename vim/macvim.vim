if has("gui_running")
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

    " Disable MacVim keybindings
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    nmap <D-f> <Esc>
    nmap <D-F> <Esc>
    macmenu &File.New\ Tab key=<nop>
    nmap <D-t> <Esc>
    macmenu &File.Open\ Tab\.\.\. key=<nop>
    nmap <D-T> <Esc>
    macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>

    " Cmd+W to close current buffer and close the window if no buffers are left
    macmenu &File.Close key=<nop>

    " Disable Cmd+S to encourage `:w`
    macmenu &File.Save key=<nop>
    map <D-s> <Esc>
    imap <D-s> <Esc><Esc>i

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
endif
