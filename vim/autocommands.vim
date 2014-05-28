if has("autocmd")
  " Disable all beeps and flashes, ALL THE FUCKING TIME!
  autocmd VimEnter * set visualbell t_vb=

  " Highlight unwanted spaces
  autocmd BufWinEnter * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft != "unite" | call clearmatches() | endif

  " Movement through splits in VimShell
  autocmd FileType vimshell nunmap <C-W>

  " Manpages are readonly and not modifiable
  " Also, don't show tabs
  autocmd FileType man setlocal readonly nomodifiable nolist
  autocmd FileType man nnoremap <buffer> <silent> q :q<CR>

  " Faster access to manpages
  autocmd FileType sh,zsh nnoremap <Leader>m :Man<Space>

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
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") && &ft != "gitcommit"
        \| exe "normal! g'\"zz" | endif

  " .m files are Objective-C
  autocmd BufRead,BufNewFile *.m set filetype=objc

  " .h files can be Objective-C
  autocmd BufRead,BufNewFile *.h if match(getline(1, min([line("$"), 200])), '^@\(interface\|end\|class\)') > -1 | set filetype=objc | endif

  " 4 Tabs/Spaces for Objective-C
  autocmd FileType objc,objcpp setlocal tabstop=4 shiftwidth=4 softtabstop=4

  autocmd BufRead,BufNewFile *.go set expandtab tabstop=2 shiftwidth=2

  " Syntax hilighting for Podfiles
  autocmd BufRead,BufNewFile Podfile set filetype=ruby

  " Spec files are RSpec
  " Used for Ultisnips
  autocmd BufRead,BufNewFile *_spec.rb set filetype=rspec.ruby

  " In help buffers:
  " - Use Enter to follow a tag
  " - Use Backspace to go back
  " - Use `q` to close the help
  autocmd filetype help nnoremap <buffer> <CR> <C-]>
  autocmd filetype help nnoremap <buffer> <BS> <C-T>
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
  autocmd FileType vim nmap <LocalLeader>b :call AddBundle()<CR>

  " Git commit messages have spellcheck and start in insert mode
  autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

  " Always start on first line of git commit message
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

  " Open new tabs at the end
  autocmd BufNew * if &showtabline && winnr("$") == 1 | tabmove | endif

  " Spell checking for Plain text files
  autocmd BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_us

  " Set max text width to 100 for text files
  autocmd BufRead,BufNewFile *.txt setlocal textwidth=100

  " .load files are fish files
  autocmd BufRead,BufNewFile *.load setf fish

  autocmd FileType fish nnoremap <LocalLeader>gf :call GenerateFishFunctionStub()<CR>

  " Prevent the CSV filetype plugin from complaining
  autocmd BufReadPre *.csv if !exists('b:delimiter') | let b:delimiter=","
  autocmd BufReadPre *.csv if !exists('b:col') | let b:col='\%(\%([^' . b:delimiter . ']*"[^"]*"[^' . b:delimiter . ']*' . b:delimiter . '\)\|\%([^' . b:delimiter . ']*\%(' . b:delimiter . '\|$\)\)\)'

  autocmd FileType ruby xmap <LocalLeader>m :call Memoize('<C-R>=GetVisualSelection()<CR>')<CR>
  autocmd FileType ruby nmap <LocalLeader>m :call Memoize('<C-R>=expand("<cword>")<CR>')<CR>
  autocmd FileType ruby,rails nnoremap <LocalLeader>r :call RunAllRSpecSpecs()<CR>

  " Markdown configuration
  augroup ft_markdown
    autocmd!
    " Enable spellcheck
    autocmd BufNewFile,BufRead,BufEnter *.md setlocal spell spelllang=en_us

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
