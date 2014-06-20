function! GlobalColorSettings()
  " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
  highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

  highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

function! OpenPluginRepoInBrowser()
  let l:line = getline(".")
  let l:match_position = match(l:line, "NeoBundle")

  if l:match_position >= 0
    let l:repo = substitute(substitute(l:line, ".*NeoBundle \"", "", "g"), "\.git\".*", "", "g")

    silent! execute "!open https://github.com/" . l:repo
  endif
endfunction

" Add Bundle item with contents of clipboard
" FIXME: The `.git` part is added just before the last char...
function! AddBundle()
  if (empty(getline('.')))
    exec "normal iNeoBundle \"\<C-O>P\<C-O>l.git\<esc>T/;dT\"o\<esc>"
  else
    exec "normal oNeoBundle \"\<C-O>P\<C-O>l.git\<esc>T/;dT\"$"
  endif
endfunction

" Used by the Memoize function below
function! GetVisualSelection()
  let l:selection = getline("'<")
  let [line1,col1] = getpos("'<")[1:2]
  let [line2,col2] = getpos("'>")[1:2]
  return l:selection[col1 - 1: col2 - 1]
endfunction

function! Memoize(string)
  let l:line = getline('.')

  let l:memoized = '#{' . a:string . '}'
  let l:line_parts = matchlist(l:line, '^\(.*\)' . a:string . '\(.*\)$')
  call remove(l:line_parts, 0)

  let l:new_line = l:line_parts[0] . l:memoized . l:line_parts[1]

  call setline('.', l:new_line)
  call search(l:memoized)
endfunction

" Save a file to an inexistant directory
function! MagicSave()
  let l:directory = expand("%:p:h")

  if !isdirectory(l:directory)
    call mkdir(l:directory, "p")

    echo "Created non-existing directory: " . l:directory
  endif
endfunction
