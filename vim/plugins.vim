filetype off

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    echo "Installing NeoBundle\n"

    silent execute '!mkdir -p ~/.vim/bundle'
    silent execute '!git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim'
  endif
endif

call neobundle#rc(expand("~/.vim/bundle/"))

" Let NeoBundle manage NeoBundle
NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle "Shougo/unite.vim.git"
NeoBundle "Shougo/unite-outline.git"
NeoBundle "Shougo/neocomplete.vim.git"
NeoBundle "Shougo/neosnippet.git"
NeoBundle "Shougo/neosnippet-snippets.git"
NeoBundle "Shougo/vimproc.git", {
      \     "build" : {
      \       "mac" : "make -f make_mac.mak"
      \     }
      \   }

NeoBundle "tpope/vim-rails.git"
NeoBundle "tpope/vim-rake.git"
NeoBundle "tpope/vim-endwise.git"
NeoBundle "tpope/vim-surround.git"
NeoBundle "tpope/vim-repeat.git"
NeoBundle "tpope/vim-commentary.git"
NeoBundle "tpope/vim-pastie.git"
NeoBundle "tpope/vim-eunuch.git"

NeoBundle "mattn/webapi-vim.git"
NeoBundle "mattn/gist-vim.git"

NeoBundle "vim-scripts/bufkill.vim.git"
NeoBundle "vim-scripts/zoomwintab.vim.git"

NeoBundle "AzizLight/base16-vim.git"
NeoBundle "AzizLight/TaskList.vim.git"
NeoBundle "AzizLight/ingo-library.git"
NeoBundle "AzizLight/EnhancedJumps.git"
NeoBundle "AzizLight/vim-markdown.git"

NeoBundle "pangloss/vim-javascript.git"
NeoBundle "leshill/vim-json.git"
NeoBundle "Yggdroot/indentLine.git"
NeoBundle "tsukkee/unite-help.git"
NeoBundle "godlygeek/tabular.git"
NeoBundle "vim-ruby/vim-ruby.git"
NeoBundle "sickill/vim-pasta.git"
NeoBundle "jiangmiao/auto-pairs.git"
NeoBundle "joedicastro/vim-multiple-cursors.git"
NeoBundle "duff/vim-bufonly.git"
NeoBundle "itchyny/lightline.vim.git"
NeoBundle "justinmk/vim-sneak.git"
NeoBundle "itspriddle/vim-marked.git"
NeoBundle "chrisbra/Colorizer.git"
NeoBundle "thinca/vim-ambicmd.git"
NeoBundle "mhinz/vim-startify.git"
NeoBundle "hail2u/vim-css3-syntax.git"
NeoBundle "jtratner/vim-flavored-markdown.git"
NeoBundle "scrooloose/syntastic.git"
NeoBundle "troydm/easytree.vim.git"
NeoBundle "zhaocai/GoldenView.Vim.git"
NeoBundle "danro/rename.vim.git"
" TODO: Use this Plugin again once my Pull Request has been merged
" NeoBundle "ntpeters/vim-better-whitespace.git"
NeoBundle "RobertAudi/vim-better-whitespace.git"

" Automatically install new plugins
NeoBundleCheck

syntax on
filetype plugin indent on

runtime macros/matchit.vim
runtime ftplugin/man.vim
