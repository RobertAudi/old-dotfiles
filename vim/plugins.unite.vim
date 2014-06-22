let g:unite_split_rule = "bot"
let g:unite_winheight = 10
" Create the unite data dir if it doesn't exist
silent !mkdir -p ~/tmp/vim/vimunite > /dev/null 2>&1
let g:unite_data_directory = "~/tmp/vim/vimunite"
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_prompt = ">>> "
let g:unite_marked_icon = "✓"

call unite#filters#matcher_default#use(["matcher_fuzzy"])
call unite#filters#sorter_default#use(["sorter_rank"])

nnoremap <C-P> :Unite -start-insert file_rec/async<CR>
nnoremap <C-B> :Unite -start-insert buffer<CR>
nnoremap <C-Y> :Unite history/yank<CR>
nnoremap <Leader>t :Unite -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
nnoremap <Leader>h :Unite -start-insert help<CR>
nnoremap <Leader>ni :Unite neobundle/install<CR>
nnoremap <Leader>nu :Unite neobundle/update<CR>
nnoremap <Leader>nc :NeoBundleClean!<CR>

if has("autocmd")
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-S> unite#do_action("split")
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-S> unite#do_action("split")
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-V> unite#do_action("vsplit")
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-V> unite#do_action("vsplit")
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-T> unite#do_action("tabopen")
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-T> unite#do_action("tabopen")

  autocmd FileType unite imap <buffer> <C-L> <Plug>(unite_redraw)
  autocmd FileType unite nmap <buffer> q <Plug>(unite_exit)
  autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
  autocmd FileType unite imap <buffer> <Esc> <Plug>(unite_exit)
endif
