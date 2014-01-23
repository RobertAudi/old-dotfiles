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
NeoBundle "tpope/vim-vinegar.git"
NeoBundle "tpope/vim-eunuch.git"

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
NeoBundle "AzizLight/vim-markdown.git"
NeoBundle "AzizLight/vim-objc.git"

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
NeoBundle "Eivy/applescript.vim.git"
NeoBundle "thinca/vim-ambicmd.git"
NeoBundle "bling/vim-bufferline.git"
NeoBundle "mhinz/vim-startify.git"
NeoBundle "hail2u/vim-css3-syntax.git"
NeoBundle "skalnik/vim-vroom.git"

syntax on
filetype plugin indent on

runtime macros/matchit.vim
