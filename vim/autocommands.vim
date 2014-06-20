if has("autocmd")
  " Disable all beeps and flashes, ALL THE FUCKING TIME!
  autocmd VimEnter * set visualbell t_vb=

  " Create directory tree if it doesn't exist when creating a new file
  autocmd BufWritePre * call MagicSave()

  " Manpages are readonly and not modifiable
  " Also, don't show tabs
  autocmd FileType man setlocal readonly nomodifiable nolist
  autocmd FileType man nnoremap <buffer> <silent> q :q<CR>

  " Faster access to manpages
  autocmd FileType sh,zsh nnoremap <buffer> <Leader>m :Man<Space>

  " Whitelist of filetypes to enable word wrap
  let word_wrap_whitelist = ['markdown', 'text']

  " Absolutely NO WRAP!!
  autocmd BufEnter,BufNewFile * if index(word_wrap_whitelist, &ft) < 0 | set nowrap | endif

  " Call the global color settings on every colorscheme change or when Vim starts.
  autocmd VimEnter,ColorScheme * call GlobalColorSettings()

  " Change the color of the ColorColumn
  autocmd BufEnter * hi ColorColumn guibg=#7b0409

  " Reopen files on the same line they were in before they were closed the
  " last time... if that makes sense...
  function! AutojumpLastPosition()
    if !exists("b:autojumped_init")
      let b:autojumped_init = 1

      if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$")
        execute "normal! g'\"zz"
      endif
    endif
  endfun
  au BufReadPost * call AutojumpLastPosition()

  " Syntax hilighting for Podfiles
  autocmd BufRead,BufNewFile Podfile set filetype=ruby

  " In help buffers:
  " - Use Enter to follow a tag
  " - Use Backspace to go back
  " - Use `q` to close the help
  autocmd FileType help nnoremap <buffer> <CR> <C-]>
  autocmd FileType help nnoremap <buffer> <BS> <C-T>
  autocmd FileType help nnoremap <buffer> <silent> q :q<CR>

  " Blacklist of filetypes where <CR> can't be remapped
  let cr_noh_mapping_blacklist = ["qf", "netrw", "unite", "help", "vimshell"]

  " Use <CR> for :noh, except for the specified filetypes
  autocmd FileType * if index(cr_noh_mapping_blacklist, &ft) < 0 | nnoremap <buffer> <CR> :noh<CR><BS> | endif

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
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

  " Always start on first line of git commit message
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

  " Open new tabs at the end
  autocmd BufNew * if &showtabline && winnr("$") == 1 | tabmove | endif

  " Set max text width to 100 for text files
  autocmd BufRead,BufNewFile *.txt setlocal textwidth=100

  autocmd FileType ruby xmap <buffer> <LocalLeader>m :call Memoize('<C-R>=GetVisualSelection()<CR>')<CR>
  autocmd FileType ruby nmap <buffer> <LocalLeader>m :call Memoize('<C-R>=expand("<cword>")<CR>')<CR>

  " Markdown configuration
  augroup ft_markdown
    autocmd!
    " Headings with ease!
    " Also capitalizes the line
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>1 guu~yypVr=
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>2 guu~yypVr-
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>3 guu~I### <ESC>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>4 guu~I#### <ESC>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>5 guu~I##### <ESC>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>6 guu~I###### <ESC>

    " Code, italic and bold
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>c ciw`<C-R>"`<ESC>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>i ciw*<C-R>"*<ESC>
    autocmd FileType markdown nnoremap <buffer> <LocalLeader>b ciw**<C-R>"**<ESC>

    " Don't break words that contain `:` or `*`
    autocmd FileType markdown setlocal breakat-=:
    autocmd FileType markdown setlocal breakat-=*

    " Enable word wrap for markdown files
    autocmd FileType markdown setlocal nolist wrap linebreak

    " Sane movement when word wrap is enabled
    " In Normal mode
    autocmd FileType markdown nnoremap <buffer> j gj
    autocmd FileType markdown nnoremap <buffer> k gk
    autocmd FileType markdown nnoremap <buffer> gj j
    autocmd FileType markdown nnoremap <buffer> gk k
    autocmd FileType markdown nnoremap <buffer> L g$
    autocmd FileType markdown nnoremap <expr> <silent> <buffer> H col('.') == match(getline('.'),'\S')+1 ? 'g0' : 'g^'
    " In Visual mode
    autocmd FileType markdown xnoremap <buffer> j gj
    autocmd FileType markdown xnoremap <buffer> k gk
    autocmd FileType markdown xnoremap <buffer> gj j
    autocmd FileType markdown xnoremap <buffer> gk k
    autocmd FileType markdown xnoremap <buffer> L g$
    autocmd FileType markdown xnoremap <expr> <silent> <buffer> H col('.') == match(getline('.'),'\S')+1 ? 'g0' : 'g^'
  augroup END
endif
