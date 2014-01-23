" bufferline
" ----------
let g:bufferline_echo = 0
nnoremap <Leader>l :echo bufferline#get_echo_string()<CR>

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
