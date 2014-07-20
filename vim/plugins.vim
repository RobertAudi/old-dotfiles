let g:plug_threads = 40

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-pastie'

Plug 'RobertAudi/base16-vim'
Plug 'RobertAudi/TaskList.vim'

Plug 'tpope/vim-markdown'
Plug 'itspriddle/vim-marked'

Plug 'vim-scripts/bufkill.vim'
Plug 'duff/vim-bufonly'
Plug 'vim-scripts/zoomwintab.vim'
Plug 'ervandew/ag'
Plug 'danro/rename.vim'
Plug 'troydm/easytree.vim'
Plug 'kien/ctrlp.vim'
Plug 'RobertAudi/ctrlp-yankring.vim'
Plug 'zhaocai/GoldenView.Vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rake'

Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'thinca/vim-ambicmd'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sickill/vim-pasta'
Plug 'thinca/vim-visualstar'
Plug 'junegunn/vim-oblique'
Plug 'ajh17/VimCompletesMe'

call plug#end()

runtime macros/matchit.vim
runtime ftplugin/man.vim
