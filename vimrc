if !filereadable(expand("~/.vim/autoload/plug.vim"))
  function! RA_InstallVimPlug()
    execute "!mkdir -p ~/.vim/autoload > /dev/null 2>&1"
    execute "!curl -sLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1"
    execute "source $HOME/.vim/plugins.vim | PlugInstall"

    if has("gui_macvim")
      set fullscreen
    endif
  endfunction

  autocmd VimEnter * echomsg "Installing vim-plug" | silent! call RA_InstallVimPlug() | set visualbell t_vb=
else
  source $HOME/.vim/plugins.vim
  source $HOME/.vim/settings.vim
  source $HOME/.vim/macvim.vim
  source $HOME/.vim/functions.vim
  source $HOME/.vim/commands.vim
  source $HOME/.vim/syntax.vim
  source $HOME/.vim/autocommands.vim
  source $HOME/.vim/mappings.vim
  source $HOME/.vim/plugins.lightline.vim
  source $HOME/.vim/plugins.misc.vim
endif
