" bufferline
" ----------
let g:bufferline_echo = 0
nnoremap <Leader>l :echo bufferline#get_echo_string()<CR>

" Javascript Libraries syntax
" ---------------------------
let g:used_javascript_libs = "angularjs,jquery"

" Dash
" ----
nmap <silent> <Leader>d <Plug>DashSearch
let g:dash_map = {
      \ "zsh"  : "man",
      \ "sh"   : "bash",
      \ "javascript" : "js",
      \ "ruby" : "gem"
      \ }

" Vim Shell
" ---------
let g:vimshell_prompt = "○ "

" GoldenRatio
" -----------
let g:golden_ratio_filetypes_blacklist = ["unite"]

" Startify
" --------
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

" Vinegar
" -------
if has("autocmd")
  autocmd FileType netrw nnoremap <silent> <buffer> <ESC> :BD<CR>
endif

" Auto-pairs
" ----------
" Auto-close pipes in ruby and rails
autocmd FileType ruby,rails let b:AutoPairs = { "(" : ")", "[" : "]", "{" : "}", "'" : "'", "\"" : "\"", "`" : "`", "|" : "|" }

" ZoomWinTab
" ----------
nnoremap <LocalLeader><LocalLeader> :ZoomWinTabToggle<CR>

" Wildfire
" --------
let g:wildfire_fuel_map = "<Space>"

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

" indentLine
" ----------
let g:indentLine_char = '│'

