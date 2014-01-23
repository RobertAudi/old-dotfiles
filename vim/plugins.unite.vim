if executable('ag')
  let g:unite_source_rec_async_command = 'ag -l --hidden --nocolor -g ""'

  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -a'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
  let g:unite_source_rec_async_command = 'ack -f --nofilter'

  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt=''
  let g:unite_source_grep_search_word_highlight = 1
endif

let g:unite_split_rule = "bot"
let g:unite_winheight = 10
" Create the unite data dir if it doesn't exist
silent !mkdir -p ~/tmp/vimunite > /dev/null 2>&1
let g:unite_data_directory = "~/tmp/vimunite"
let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_prompt = '>>> '
let g:unite_marked_icon = '✓'

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :Unite -start-insert file_rec/async<CR>
nnoremap <C-B> :Unite -start-insert buffer<CR>
nnoremap <C-F> :Unite grep:.<CR>
nnoremap <C-Y> :Unite history/yank<CR>
nnoremap <Leader>t :Unite -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
nnoremap <Leader>h :Unite -start-insert help<CR>
nnoremap <Leader>ni :Unite neobundle/install<CR>
nnoremap <Leader>nu :Unite neobundle/update<CR>
nnoremap <Leader>nc :NeoBundleClean<CR>
nnoremap <LocalLeader>tt :Unite grep:**::TODO\|FIXME\|IMPROVE\|BUG\|!!!<CR>

if has("autocmd")
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-S> unite#do_action('split')
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-S> unite#do_action('split')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-V> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')

  autocmd FileType unite imap <buffer> <C-L> <Plug>(unite_redraw)
  autocmd FileType unite nmap <buffer> q <Plug>(unite_exit)
  autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
  autocmd FileType unite imap <buffer> <Esc> <Plug>(unite_exit)
endif
