" Settings
" ========
if has("vim_starting")
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand("~/.vim/bundle/"))

" Let NeoBundle manage NeoBundle
NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/unite.vim.git"
NeoBundle "Shougo/unite-outline.git"
NeoBundle "Shougo/neocomplete.vim.git"
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \    },
      \ }

NeoBundle "tpope/vim-bundler.git"
NeoBundle "tpope/vim-rails.git"
NeoBundle "tpope/vim-rake.git"
NeoBundle "tpope/vim-endwise.git"
NeoBundle "tpope/vim-surround.git"
NeoBundle "tpope/vim-repeat.git"
NeoBundle "tpope/vim-commentary.git"
NeoBundle "tpope/vim-fugitive.git"
NeoBundle "tpope/vim-pastie.git"
NeoBundle "tpope/vim-markdown.git"
NeoBundle "tpope/vim-vinegar.git"

NeoBundle "mattn/emmet-vim.git"
NeoBundle "mattn/webapi-vim.git"
NeoBundle "mattn/gist-vim.git"

NeoBundle "vim-scripts/bufkill.vim.git"
NeoBundle "vim-scripts/zoomwintab.vim.git"

NeoBundle "AzizLight/base16-vim.git"
NeoBundle "AzizLight/snippets.vim.git"
NeoBundle "AzizLight/golden-ratio.git"
NeoBundle "AzizLight/vim-fish.git"
NeoBundle "AzizLight/TaskList.vim.git"
NeoBundle "AzizLight/ingo-library.git"
NeoBundle "AzizLight/EnhancedJumps.git"

NeoBundle "pangloss/vim-javascript.git"
NeoBundle "leshill/vim-json.git"
NeoBundle "Yggdroot/indentLine.git"
NeoBundle "tsukkee/unite-help.git"
NeoBundle "godlygeek/tabular.git"
NeoBundle "vim-ruby/vim-ruby.git"
NeoBundle "sunaku/vim-ruby-minitest.git"
NeoBundle "int3/vim-extradite.git"
NeoBundle "chrisbra/csv.vim.git"
NeoBundle "sickill/vim-pasta.git"
NeoBundle "jiangmiao/auto-pairs.git"
NeoBundle "SirVer/ultisnips.git"
NeoBundle "joedicastro/vim-multiple-cursors.git"
NeoBundle "duff/vim-bufonly.git"
NeoBundle "Lokaltog/vim-easymotion.git"
NeoBundle "itchyny/lightline.vim.git"
NeoBundle "justinmk/vim-sneak.git"
NeoBundle "itspriddle/vim-marked.git"
NeoBundle "gorodinskiy/vim-coloresque.git"
" NeoBundle "roman/golden-ratio.git"
NeoBundle "Eivy/applescript.vim.git"
NeoBundle "thinca/vim-ambicmd.git"

syntax on
filetype plugin indent on

runtime macros/matchit.vim

set history=1000
set shell=sh

" Disable word-wrap
set nowrap

" Disable folding!
set nofoldenable

" Display an incomplete command in
" the lower right corner of the Vim window
set showcmd

" Use the OS X Clipboard
set clipboard=unnamed

set hidden
set hlsearch    " highlight search
set ignorecase
set smartcase
set incsearch

scriptencoding utf-8
set encoding=utf-8

set novisualbell  " No blinking
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set showmatch     " Show matching brackets.

" Disable modelines completely
set modelines=0
set nomodeline

" New window goes below
set splitbelow

" New windows goes right
set splitright

" I hate line numbers
set nonumber
set norelativenumber

" Automatically update buffers when the filesystem file changes
set autoread

" Automatically save the file when switching buffers. See :h aw
set autowriteall

" Highlight the current line
set cursorline
set colorcolumn=100

" When the page starts to scroll, keep the cursor
" 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Same as above but for horizontal scrolling
set sidescrolloff=8

" Fix Backspace
set backspace=indent,eol,start

" Only insert single space after a '.', '?' and '!' with a join command.
set nojoinspaces

" Don't reset cursor to start of line when moving around.
set nostartofline

" Color scheme
let base16colorspace=256
set background=dark
colorscheme base16-railscasts

" Disable backups, swaps and all that shit"
set nobackup
set nowritebackup
set noswapfile

"Save buffer every 10 chars typed
set updatecount=10

" Persistent Undo
set undofile                " Save undo's after file closes
" Create the undo dir if it doesn't exist
silent !mkdir -p ~/tmp/vimundo > /dev/null 2>&1
set undodir=$HOME/tmp/vimundo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Tab completion
" --------------
set wildmenu
set wildmode=list:longest,full
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.DS_Store                       " OS X bullshit

" Whitespace
" ----------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set list
set list listchars=tab:‣\ ,trail:·,extends:…,precedes:…,nbsp:˖

" Functions
" =========
function! GlobalColorSettings()
  " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
  highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

  highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

function! EditMultipleFiles(...)
  if a:0 == 0
    echoerr "No file specified..."
  else
    let i = a:0
    while i > 0
      execute 'let file = a:' . i
      execute 'edit ' . file
      let i = i - 1
    endwhile
  endif
endfunction
command! -nargs=* -complete=file EM call EditMultipleFiles(<f-args>)

" Generate a fish function stub with a name based on the filename
function! GenerateFishFunctionStub()
  if &ft != "fish"
    return
  endif

  exec "normal iend"
  exec "normal Ofunction " . substitute(expand('%:t'), '\.fish$', '', '')
  exec "startinsert!"
endfunction
autocmd FileType fish nnoremap <LocalLeader>gf :call GenerateFishFunctionStub()<CR>

" Add Bundle item with contents of clipboard
" FIXME: The `.git` part is added just before the last char...
function! AddBundle()
  if (empty(getline('.')))
    exec "normal iNeoBundle \"\<C-O>P\<C-O>l.git\<esc>T/;dT\"o\<esc>"
  else
    exec "normal oNeoBundle \"\<C-O>P\<C-O>l.git\<esc>T/;dT\"$"
  endif
endfunction
autocmd FileType vim nmap <LocalLeader>b :call AddBundle()<CR>

function! GetVisualSelection()
  let l:selection = getline("'<")
  let [line1,col1] = getpos("'<")[1:2]
  let [line2,col2] = getpos("'>")[1:2]
  return l:selection[col1 - 1: col2 - 1]
endfunction

function! Memoize(string)
  let l:line = getline('.')

  let l:memoized = '#{' . a:string . '}'
  let l:line_parts = matchlist(l:line, '^\(.*\)' . a:string . '\(.*\)$')
  call remove(l:line_parts, 0)

  let l:new_line = l:line_parts[0] . l:memoized . l:line_parts[1]

  call setline('.', l:new_line)
  call search(l:memoized)
endfunction
autocmd FileType ruby xmap <LocalLeader>m :call Memoize('<C-R>=GetVisualSelection()<CR>')<CR>
autocmd FileType ruby nmap <LocalLeader>m :call Memoize('<C-R>=expand("<cword>")<CR>')<CR>

" Rename file in current buffer
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nnoremap <LocalLeader>rf :call RenameFile()<CR>

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" Save a file to an inexistant directory
function! MagicSave(...)
  if a:0
    let directory = fnamemodify(a:1, ':p:h')
    let file = a:1
  else
    let directory = expand('%:p:h')
    let file = expand('%')
  endif
  if !isdirectory(directory)
    call mkdir(directory, 'p')
  endif
  execute 'write' file
endfunction
command! -nargs=? WW call MagicSave(<q-args>)

" Count the number of words in the file
" omitting the headers
function! WordCount()
  " This function only works in Markdown files
  if &filetype != 'markdown'
    return
  endif

  let l:currentLine = 0
  let l:numOfLines = line('$')
  let l:current = 0

  while l:currentLine <= l:numOfLines
    let l:currentLineContent = getline(l:currentLine)
    let l:nextLineContent = getline(l:currentLine + 1)

    if match(l:currentLineContent, '^#\+ .\+') >= 0
      let l:currentLine += 1
      continue
    elseif match(l:nextLineContent, '^[=-]\+$') >= 0
      let l:currentLine += 2
      continue
    else
      let l:numOfWordsInLine = tlib#string#TrimLeft(system('echo "' . l:currentLineContent . '" | wc -w'))
      let l:current += l:numOfWordsInLine
      let l:currentLine += 1
    endif
  endw

  echo 'Words: ' . l:current
endfunction

" Commands
" ========
" Taken from http://blog.sanctum.geek.nz/vim-command-typos/
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Wqa wqa<bang>
command! -bang WQa wqa<bang>
command! -bang WQA wqa<bang>

" Save and make executable
command! -bang WX w | !chmod a+x %

" Auto-commands
" ==============================================================================
" Disable all beeps and flashes, ALL THE FUCKING TIME!
autocmd VimEnter * set visualbell t_vb=

" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=#d63639
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+$/ | endif
autocmd InsertEnter * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
autocmd InsertLeave * if &modifiable && &ft != "unite" | match ExtraWhitespace /\s\+$/ | endif
autocmd BufWinLeave * if &modifiable && &ft != "unite" | call clearmatches() | endif

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
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"zz" | endif

" 4 Tabs/Spaces for Objective-C
autocmd FileType objc,objcpp setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Auto-close pipes in ruby and rails
autocmd FileType ruby,rails let b:AutoPairs = { "(" : ")", "[" : "]", "{" : "}", "'" : "'", "\"" : "\"", "`" : "`", "|" : "|" }

" Syntax hilighting for Podfiles
autocmd BufRead,BufNewFile Podfile set filetype=ruby

" In help buffers, use `q` to close the help
autocmd FileType help nnoremap <buffer> q :q<CR>

" Blacklist of filetypes where <CR> can't be remapped
let cr_noh_mapping_blacklist = ["qf", "netrw", "unite"]

" Use <CR> for :noh, except for the specified filetypes
autocmd FileType * if index(cr_noh_mapping_blacklist, &ft) < 0 | nnoremap <buffer> <CR> :noh<CR><BS> | endif

" set 'updatetime' to 15 seconds when in insert mode
autocmd InsertEnter * let updaterestore = &updatetime | set updatetime=15000
autocmd InsertLeave * let &updatetime = updaterestore

" automatically leave insert mode after 'updatetime' milliseconds of inaction
autocmd CursorHoldI * stopinsert

" Leave Insert mode when Vim lost focus
autocmd FocusLost * call feedkeys("\<C-[>")

" Always start on first line of git commit message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Vimscript comment headers
autocmd FileType vim nmap <buffer> <LocalLeader>1 ^vg_olly:set noautoindent nosmartindent<CR>o<BS> <ESC>p^vg_ollr=:set autoindent smartindent<CR>
autocmd FileType vim nmap <buffer> <LocalLeader>2 ^vg_olly:set noautoindent nosmartindent<CR>o<BS> <ESC>p^vg_ollr-:set autoindent smartindent<CR>

" Git commit messages have spellcheck and start in insert mode
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

" Open new tabs at the end
autocmd BufNew * if &showtabline && winnr("$") == 1 | tabmove | endif

" Spell checking for Plain text files
autocmd BufNewFile,BufRead,BufEnter *.txt setlocal spell spelllang=en_us

" Set max text width to 100 for text files
autocmd BufRead,BufNewFile *.txt setlocal textwidth=100

" .load files are fish files
autocmd BufRead,BufNewFile *.load setf fish

" Prevent the CSV filetype plugin from complaining
autocmd BufReadPre *.csv if !exists('b:delimiter') | let b:delimiter=","
autocmd BufReadPre *.csv if !exists('b:col') | let b:col='\%(\%([^' . b:delimiter . ']*"[^"]*"[^' . b:delimiter . ']*' . b:delimiter . '\)\|\%([^' . b:delimiter . ']*\%(' . b:delimiter . '\|$\)\)\)'

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

" Map leaders
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"
let g:maplocalleader = "\\"

" Plugins
" =======
" Unite
" -----
if executable('ag')
  let g:unite_source_rec_async_command = 'ag -l --hidden --nocolor -g ""'

  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -a -C4'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
  let g:unite_source_rec_async_command = 'ack -f --nofilter'

  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_grep_search_word_highlight = 1
endif

let g:unite_split_rule = "bot"
let g:unite_winheight = 10
" Create the unite data dir if it doesn't exist
silent !mkdir -p ~/tmp/vimunite > /dev/null 2>&1
let g:unite_data_directory = "~/tmp/vimunite"
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_prompt = '>>> '
let g:unite_marked_icon = '✓'

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :Unite -start-insert file_rec/async<CR>
nnoremap <C-B> :Unite -start-insert -quick-match buffer<CR>
nnoremap <C-F> :Unite grep:.<CR>
nnoremap <C-Y> :Unite history/yank<CR>
nnoremap <Leader>t :Unite -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
nnoremap <Leader>h :Unite -start-insert help<CR>
nnoremap <Leader>ni :Unite neobundle/install<CR>
nnoremap <Leader>nu :Unite neobundle/update<CR>
nnoremap <Leader>nc :NeoBundleClean<CR>

autocmd FileType unite inoremap <silent> <buffer> <expr> <C-S> unite#do_action('split')
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-S> unite#do_action('split')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
" TODO: Do the same as the above but for tabs

autocmd FileType unite nmap <buffer> q <Plug>(unite_exit)
autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
autocmd FileType unite imap <buffer> <Esc> <Plug>(unite_exit)

" NeoComplete
" -----------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><TAB>  pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-H>"
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() . "\<Space>" : "\<Space>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" GoldenRatio
" -----------
let g:golden_ratio_filetypes_blacklist = ["unite"]

" Vinegar
" -------
autocmd FileType netrw nnoremap <silent> <buffer> <ESC> :BD<CR>

" ZoomWinTab
" ----------
nnoremap <LocalLeader><LocalLeader> :ZoomWinTabToggle<CR>

" EasyMotion
" ----------
let g:EasyMotion_mapping_f = '<Space>'
let g:EasyMotion_mapping_b = '<S-Space>'

" AmbiCMD
" -------
cnoremap <expr> <Space> ambicmd#expand("\<Space>")

" Gist.vim
" --------
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL%'

" Commentary
" ----------
nmap gx gccyypgcc
nmap <C-\> gcc
xmap <C-\> gc

" UltiSnips
" ---------
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsExpandTrigger = "<C-J>"

" Surround
" --------
" Quickly surroun the word under the cursor
nnoremap <C-W> viwS

" indentLine
" ----------
let g:indentLine_char = '│'

" Lightline
" ---------
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" MacVim shit
" ===========
if has('gui_running')
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

  let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
        \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'MyFugitive',
        \   'readonly': 'MyReadonly',
        \   'modified': 'MyModified',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \ },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \ }

  function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
  endfunction

  function! MyFilename()
    let fname = expand('%:t')
    return &ft == 'unite' ? unite#get_status_string() :
          \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ ('' != fname ? fname : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyFugitive()
    try
      if exists('*fugitive#head')
        let mark = ' '  " edit here for cool mark
        let _ = fugitive#head()
        return strlen(_) ? mark._ : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyMode()
    let fname = expand('%:t')
    return &ft == 'unite' ? 'Unite' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction
endif

" Mappings
" ========
" No Help, please
nmap <F1> <Esc>

" Disable Ex mode
nnoremap Q <Nop>

" Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" Yank and go to end of selection
xnoremap y y`]

" Paste in visual mode should not replace the default register with the
" deleted text
xnoremap p "_dP

" . in visual mode
xnoremap . :normal .<CR>

" Repeats macro on every line
xnoremap @ :normal@

" Indent/Unindent
xmap <Tab> >
xmap <S-Tab> <

" Faster line completion
imap <C-L> <C-X><C-L>

" Isolate a line
nnoremap <leader><space><space> O<C-O>j<C-O>o<C-O>k<esc>

" Isolate Visual selection
xnoremap <leader><space><space> dO<cr><esc>P

" Same as C-O/C-I but centers the text
nmap <C-O> <C-O>zz
nmap <C-I> <C-I>zz

" Bubble single lines
nnoremap <Up> ddkP
nnoremap <Down> ddp

" Bubble multiple lines
xnoremap <Up> xkP`[V`]
xnoremap <Down> xp`[V`]

" Command Mode maps
" Heresy.
cnoremap <C-A> <home>
cnoremap <C-E> <end>
cnoremap <C-P> <up>
cnoremap <C-N> <down>
cnoremap <C-F> <right>
cnoremap <C-B> <left>

" Taken from https://github.com/dubgeiser/vimconfig
" Do not exit visual mode when shifting
xnoremap > >gv
xnoremap < <gv

" Visual Block mode is far more useful that Visual mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v

" Make vaa select the entire file
nnoremap <Leader>a :keepjumps normal ggVG<CR>

" Keep search matches in the middle of the window
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't move on */#
nnoremap <silent>* *zz
nnoremap <silent># #zz

" _ : Quick horizontal splits
nnoremap _ :sp<CR>

" | : Quick vertical splits
nnoremap <bar> :vsp<CR>

" Movement through splits
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Search for selected text, forwards or backwards.
xnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
xnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Next/Previous buffer
noremap <C-Left> :bprev<CR>
noremap <C-Right> :bnext<CR>
noremap <S-Left> :tabprev<CR>
noremap <S-Right> :tabnext<CR>
noremap <Leader>nt :tabnew<CR>

" Opens an edit command with the path of the currently edited file filled in
nmap <LocalLeader>e :e <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <LocalLeader>te :tabe <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>tee :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Opens an edit command with the path of the fish functions directory filled in
nnoremap <expr> <LocalLeader>ff getcwd() =~ $HOME . "/.homesick/repos/dotfiles" ? ':e <C-R>=getcwd()<CR>/home/.config/fish/functions/' : ':echoerr "You are not in the dotfiles directory!"<CR>'

" Uppercase!
inoremap <C-U> <esc>gUiwea

" Select (linewise) the text you just pasted.
nnoremap <leader>v V`]

" Auto-indent the code just pasted
nnoremap <LocalLeader>] V`]=

" Select the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Remap H and L to beggining and end of the line
nnoremap <expr> <silent> H col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
xnoremap <expr> <silent> H col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
nnoremap L $
xnoremap L $h

" Make Y consistent with C and D
nnoremap Y y$

" Easier search
nnoremap <Leader>s :%s//g<Left><Left>
xnoremap <Leader>s :s//g<Left><Left>
nnoremap <LocalLeader>s :%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

" Use a bar-shaped cursor for insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Use the mouse in the terminal!!
if has("mouse")
  set mouse=a
endif

" Additional highlight groups
hi! link txtBold Identifier
hi! link zshVariableDef Identifier
hi! link zshFunction Function
hi! link rubyControl Statement
hi! link rspecGroupMethods rubyControl
hi! link rspecMocks Identifier
hi! link rspecKeywords Identifier
hi! link rubyLocalVariableOrMethod Normal
hi! link rubyStringDelimiter Constant
hi! link rubyString Constant
hi! link rubyAccess Todo
hi! link rubySymbol Identifier
hi! link rubyPseudoVariable Type
hi! link rubyRailsARAssociationMethod Title
hi! link rubyRailsARValidationMethod Title
hi! link rubyRailsMethod Title
hi IncSearch cterm=NONE ctermfg=Black ctermbg=154 gui=NONE guifg=#000000 guibg=#c0cd38
