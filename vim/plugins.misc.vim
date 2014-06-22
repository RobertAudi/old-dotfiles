" GoldenView
" ----------
let g:goldenview__enable_default_mapping = 0

" Bonly
" -----
nnoremap <C-S> :Bonly<CR>

" EasyTree
" --------
let g:easytree_auto_save_settings = 1

function! FocusOrToggleEasyTree()
  if getbufvar(winbufnr(1), "&filetype") == "easytree" && &filetype != "easytree"
    execute 1 . "wincmd w"
  else
    execute "EasyTreeToggle"
  endif
endfunction
nnoremap - :call FocusOrToggleEasyTree()<CR>

" Auto-pairs
" ----------
" Auto-close pipes in ruby and rails
autocmd FileType ruby,rails let b:AutoPairs = { "(" : ")", "[" : "]", "{" : "}", "'" : "'", "\"" : "\"", "`" : "`", "|" : "|" }

" ZoomWinTab
" ----------
nnoremap <LocalLeader><LocalLeader> :ZoomWinTabToggle<CR>

" AmbiCMD
" -------
cnoremap <expr> <Space> ambicmd#expand("\<Space>")

" Gist.vim
" --------
let g:gist_clip_command = "pbcopy"
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = "open %URL%"

" Commentary
" ----------
nmap gx gccyypgcc

" indentLine
" ----------
let g:indentLine_char = "│"

" rename.vim
" ----------
nnoremap <LocalLeader>rf :Rename!<Space>

" Better whitespace
" -----------------
highlight ExtraWhitespace ctermbg=red guibg=#d63639
let g:better_whitespace_filetypes_blacklist = ["qf", "unite", "help", "easytree"]
let g:strip_whitespace_on_save = 1

" Ag
" --
command! -bang -nargs=1 F Ag<bang> --smart-case --hidden <args>
nnoremap <C-F> :F!<Space>
nnoremap <silent> <LocalLeader>f :copen<CR>
