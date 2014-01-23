function! GlobalColorSettings()
  " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
  highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

  highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction

function! EditMultipleFiles(...)
  if a:0 == 0
    echoerr "No file specified..."
  else
    let i = a:0
    while i > 0
      execute 'let file = a:' . i
      execute 'edit ' . file
      let i = i - 1
    endwhile
  endif
endfunction

" Generate a fish function stub with a name based on the filename
function! GenerateFishFunctionStub()
  if &ft != "fish"
    return
  endif

  exec "normal iend"
  exec "normal Ofunction " . substitute(expand('%:t'), '\.fish$', '', '')
  exec "startinsert!"
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

" Rename file in current buffer
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':bd ' . bufnr("#")
    redraw!
  endif
endfunction

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" Save a file to an inexistant directory
function! MagicSave(...)
  if a:0
    let directory = fnamemodify(a:1, ':p:h')
    let file = a:1
  else
    let directory = expand('%:p:h')
    let file = expand('%')
  endif
  if !isdirectory(directory)
    call mkdir(directory, 'p')
  endif
  execute 'write' file
endfunction

" Count the number of words in the file
" omitting the headers
function! WordCount()
  " This function only works in Markdown files
  if &filetype != 'markdown'
    return
  endif

  let l:currentLine = 0
  let l:numOfLines = line('$')
  let l:current = 0

  while l:currentLine <= l:numOfLines
    let l:currentLineContent = getline(l:currentLine)
    let l:nextLineContent = getline(l:currentLine + 1)

    if match(l:currentLineContent, '^#\+ .\+') >= 0
      let l:currentLine += 1
      continue
    elseif match(l:nextLineContent, '^[=-]\+$') >= 0
      let l:currentLine += 2
      continue
    else
      let l:numOfWordsInLine = tlib#string#TrimLeft(system('echo "' . l:currentLineContent . '" | wc -w'))
      let l:current += l:numOfWordsInLine
      let l:currentLine += 1
    endif
  endw

  echo 'Words: ' . l:current
endfunction

function! RunAllRSpecSpecs()
  if executable("rspec")
    if isdirectory("spec")
      exec ":!rspec --no-color spec"
    else
      echoerr "spec directory not found"
    endif
  else
    echoerr "RSpec not installed!"
  endif
endfunction
