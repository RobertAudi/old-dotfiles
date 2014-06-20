" GoldenView
" ----------
let g:goldenview__enable_default_mapping = 0

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

" Startify
" --------
autocmd FileType startify setlocal buftype=
let g:startify_change_to_dir = 0
let g:startify_skiplist = [
      \ ".git",
      \ ".gems"
      \ ]
let g:startify_list_order = [
      \ [' Last recently modified files in the current directory:'],
      \ 'dir',
      \ [' Last recently opened files:'],
      \ 'files'
      \ ]

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
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL%'

" Commentary
" ----------
nmap gx gccyypgcc

" indentLine
" ----------
let g:indentLine_char = '│'

" rename.vim
" ----------
nnoremap <LocalLeader>rf :Rename!<Space>

" Better whitespace
" -----------------
highlight ExtraWhitespace ctermbg=red guibg=#d63639
let g:better_whitespace_filetypes_blacklist = ["qf", "unite", "help", "easytree", "startify"]
let g:strip_whitespace_on_save = 1
