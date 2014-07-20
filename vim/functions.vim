function! GlobalColorSettings()
  " Set "TODO" & "FIXME" strings to be bold and standout as hell.
  highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

  highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

function! OpenPluginRepoInBrowser()
  let l:line = getline(".")
  let l:match_position = match(l:line, "Plug")

  if l:match_position >= 0
    let l:repo = substitute(substitute(l:line, " *Plug '", "", "g"), "'.*", "", "g")

    execute "silent! !open -g https://github.com/" . l:repo
  endif
endfunction

" Add Bundle item with contents of clipboard
" FIXME: The `.git` part is added just before the last char...
function! AddBundle()
  if (empty(getline(".")))
    execute "normal iPlug '\<C-O>P\<esc>T/;dT'o\<esc>"
  else
    execute "normal oPlug '\<C-O>P\<esc>T/;dT'$"
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
  let l:line = getline(".")

  let l:memoized = "#{" . a:string . "}"
  let l:line_parts = matchlist(l:line, "^\(.*\)" . a:string . "\(.*\)$")
  call remove(l:line_parts, 0)

  let l:new_line = l:line_parts[0] . l:memoized . l:line_parts[1]

  call setline(".", l:new_line)
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

" Append stuff to all the selected lines
function! RAAppend() range
  call inputsave()
  let l:str = input("> ")
  call inputrestore()

  redraw!

  if strlen(l:str) > 0
    execute a:firstline . "," . a:lastline . "normal A" . l:str
  endif
endfunction
xnoremap <C-A> :call RAAppend()<CR>

function! RAToCamelcase(word)
  let word = substitute(a:word, '-', '_', 'g')

  if word !~# '_' && word =~# '\l'
    return substitute(word,'^.','\l&','')
  else
    return substitute(word,'\C\(_\)\=\(.\)','\=submatch(1)==""?tolower(submatch(2)) : toupper(submatch(2))','g')
  endif
endfunction

function! RAToSnakecase(word)
  let word = substitute(a:word,'::','/','g')
  let word = substitute(word,'\(\u\+\)\(\u\l\)','\1_\2','g')
  let word = substitute(word,'\(\l\|\d\)\(\u\)','\1_\2','g')
  let word = substitute(word,'[.-]','_','g')
  let word = tolower(word)

  return word
endfunction

function! RAToggleCase(word)
  let l:new_word = ""

  if match(a:word, "_") > 0
    let l:new_word = RAToCamelcase(a:word)
  else
    let l:new_word = RAToSnakecase(a:word)
  endif

  let l:position = getpos(".")

  execute 's/' . a:word . '/' . l:new_word . '/g'

  call setpos(".", l:position)
endfunction
nnoremap <silent> gt :call RAToggleCase("<C-R>=expand("<cword>")<CR>")<CR>
