" GoldenView
" ----------
let g:goldenview__enable_default_mapping = 0

" EasyTree
" --------
let g:easytree_auto_save_settings = 1

function! FocusOrToggleEasyTree()
  let l:tabuflist = copy(tabpagebuflist())
  let l:filetypes = map(copy(l:tabuflist), "getbufvar(v:val, '&filetype')")
  let l:easytreebufindex = index(l:filetypes, "easytree")

  if l:easytreebufindex >= 0
    let l:easytreewinindex = l:tabuflist[l:easytreebufindex]

    if bufnr("%") == l:easytreewinindex
      execute bufwinnr("#") . "wincmd w"
    else
      execute bufwinnr(l:easytreewinindex) . "wincmd w"
    endif
  else
    execute "EasyTree"
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
xmap <silent> <expr> gx 'gcgvyp`[' . strpart(getregtype(), 0, 1) . '`]gc'

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
let g:AgSmartCase = 1
command! -bang -nargs=+ F Ag<bang> --hidden <args>
nnoremap <C-F> :F!<Space>
nnoremap <silent> <LocalLeader>f :copen<CR>

" CtrlP
" -----
let g:ctrlp_user_command = [".git", "cd %s && git ls-files --others --cached --exclude-standard"]
nnoremap <C-B> :CtrlPBuffer<CR>
nnoremap <C-Y> :CtrlPYankring<CR>

" vim-gitgutter
" -------------
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0


" vim-oblique
" -----------
hi! def link ObliqueCurrentMatch IncSearch
hi! def link ObliquePrompt       Structure
hi! def link ObliqueLine         String

" Railscasts
" ----------
let base16colorspace=256
colorscheme base16-railscasts

" Tabularize
" ----------
function! RAAlign() range
  call inputsave()
  let l:str = input("> ")
  call inputrestore()

  redraw!

  if strlen(l:str) > 0
    execute a:firstline . "," . a:lastline . "Tabularize /" . l:str
  endif
endfunction
xnoremap <Leader>a :call RAAlign()<CR>
