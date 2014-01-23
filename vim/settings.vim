" Required for some plugins
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

" Disable backups, swaps and all that shit"
silent !mkdir -p ~/tmp/vimbackup > /dev/null 2>&1
set backupdir=~/tmp/vimbackup
set directory=~/tmp/vimbackup
set backup

"Save buffer every 10 chars typed
set updatecount=10

" History
set history=1000

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

" Use the mouse in the terminal!!
if has("mouse")
  set mouse=a
endif

" Color scheme
set background=dark
let base16colorspace=256
colorscheme base16-railscasts

" Use a bar-shaped cursor for insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
