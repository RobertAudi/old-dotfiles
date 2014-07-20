augroup vimrc
  autocmd!

  " Disable all beeps and flashes, ALL THE FUCKING TIME!
  autocmd VimEnter * set visualbell t_vb=

  " Create directory tree if it doesn't exist when creating a new file
  autocmd BufWritePre * call MagicSave()

  " Manpages are readonly and not modifiable
  " Also, don't show tabs
  autocmd FileType man setlocal readonly nomodifiable nolist

  " Faster access to manpages
  autocmd FileType sh,zsh nnoremap <buffer> <Leader>m :Man<Space>

  " Absolutely NO WRAP!!
  autocmd BufEnter,BufNewFile set nowrap

  " Call the global color settings on every colorscheme change or when Vim starts.
  autocmd VimEnter,ColorScheme * call GlobalColorSettings()

  " Quit with q on Vim startup if no file has been opened
  autocmd VimEnter * if len(filter(range(1, bufnr("$")), "buflisted(v:val)")) == 1 &&
        \ &filetype == "" &&
        \ expand("%:t") == "" |
        \ nnoremap <silent> <buffer> q :q<CR> |
        \ endif

  " Change the color of the ColorColumn
  autocmd BufEnter * hi ColorColumn guibg=#7b0409

  " Reopen files on the same line they were in before they were closed the
  " last time... if that makes sense...
  function! AutojumpLastPosition()
    if !exists("b:autojumped_init")
      let b:autojumped_init = 1

      if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$")
        execute "normal! g'\"zz"
      endif
    endif
  endfun
  autocmd BufReadPost * call AutojumpLastPosition()

  " Syntax hilighting for Podfiles
  autocmd BufRead,BufNewFile Podfile set filetype=ruby

  " In help buffers:
  " - Use Enter to follow a tag
  " - Use Backspace to go back
  " - Use `q` or `Esc` to close the help (and the quickfix window)
  autocmd FileType help nnoremap <buffer> <CR> <C-]>
  autocmd FileType help nnoremap <buffer> <BS> <C-T>
  autocmd FileType help,qf,man nnoremap <buffer> <silent> q :q<CR>
  autocmd FileType help,qf,man nnoremap <buffer> <silent> <Esc> :q<CR>

  let default_timeoutlen_filetypes = ["help", "qf", "man"]
  autocmd BufEnter,BufNewFile * if index(default_timeoutlen_filetypes, &filetype) < 0 | set timeoutlen=1000 | endif
  autocmd BufEnter,BufNewFile * if index(default_timeoutlen_filetypes, &filetype) >= 0 | set timeoutlen=0 | endif
  autocmd FileType help,qf,man nnoremap <buffer> <silent> d <C-D>
  autocmd FileType help,qf,man nnoremap <buffer> <silent> u <C-U>

  " Stay in the quickfix window when going through search results
  " TODO: Highlight the current search result
  autocmd FileType qf nmap <buffer> <CR> <CR>:copen<CR>

  " Blacklist of filetypes where <CR> can't be remapped
  let cr_noh_mapping_blacklist = ["qf", "unite", "help"]

  " Use <CR> for :noh, except for the specified filetypes
  autocmd FileType * if index(cr_noh_mapping_blacklist, &filetype) < 0 | nnoremap <buffer> <CR> :noh<CR><BS> | endif

  " Leave Insert mode when Vim lost focus
  autocmd FocusLost * call feedkeys("\<C-[>")

  " Vimscript comment headers
  autocmd FileType vim nmap <buffer> <LocalLeader>1 ^vg_olly:set noautoindent nosmartindent<CR>o<BS> <ESC>p^vg_ollr=:set autoindent smartindent<CR>
  autocmd FileType vim nmap <buffer> <LocalLeader>2 ^vg_olly:set noautoindent nosmartindent<CR>o<BS> <ESC>p^vg_ollr-:set autoindent smartindent<CR>

  " Add a bundle line with the content of the clipboard
  autocmd FileType vim nmap <buffer> <LocalLeader>b :call AddBundle()<CR>

  " Open the github repo of the plugin under the cursor
  autocmd FileType vim nmap <buffer> <silent> <LocalLeader>o :call OpenPluginRepoInBrowser()<CR>

  " Git commit messages start in insert mode
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys("ggi", "t")

  " Always start on first line of git commit message
  autocmd FileType gitcommit call setpos(".", [0, 1, 1, 0])

  " Open new tabs at the end
  autocmd BufNew * if &showtabline && winnr("$") == 1 | tabmove | endif

  " Set max text width to 100 for text files
  autocmd BufRead,BufNewFile *.txt setlocal textwidth=100

  autocmd FileType ruby xmap <buffer> <LocalLeader>m :call Memoize("<C-R>=GetVisualSelection()<CR>")<CR>
  autocmd FileType ruby nmap <buffer> <LocalLeader>m :call Memoize("<C-R>=expand("<cword>")<CR>")<CR>

  " Markdown configuration
  " ----------------------
  " Headings with ease!
  " Also capitalizes the line
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>1 guu~yypVr=
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>2 guu~yypVr-
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>3 guu~I### <ESC>
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>4 guu~I#### <ESC>
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>5 guu~I##### <ESC>
  autocmd FileType markdown nnoremap <buffer> <LocalLeader>6 guu~I###### <ESC>
augroup END
