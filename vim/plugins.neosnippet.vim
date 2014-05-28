let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['ruby'] = 'ruby,ruby-rails'
let g:neosnippet#scope_aliases['zsh'] = 'sh'

imap <C-J>     <Plug>(neosnippet_expand_or_jump)
smap <C-J>     <Plug>(neosnippet_expand_or_jump)
xmap <C-J>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=i
endif
