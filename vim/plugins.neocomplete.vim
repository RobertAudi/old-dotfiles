let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#tags#cache_limit_size = 10000000
let g:neocomplete#max_list = 25

call neocomplete#custom#source('tag', 'converters',
      \ ['converter_remove_last_paren',
      \  'converter_delimiter', 'converter_case',
      \  'converter_disable_abbr', 'converter_abbr'])

inoremap <expr><TAB>  pumvisible() ? "\<C-N>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-P>" : "\<TAB>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-H>"
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() . "\<Space>" : "\<Space>"

if has("autocmd")
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

  " Disable ruby omni completion cause it's fucking broken!
  autocmd FileType ruby setlocal omnifunc=
endif
