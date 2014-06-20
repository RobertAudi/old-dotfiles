let g:ra_git_branch_fetched = 0
let g:ra_git_branch_name = ""

autocmd BufEnter,FocusGained * call RARefreshGitBranch()

function! RAModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! RAReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! RAFilename()
  let fname = expand('%:t')
  return &ft == 'unite' ? unite#get_status_string() :
        \ ('' != RAReadonly() ? RAReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != RAModified() ? ' ' . RAModified() : '')
endfunction

function! RARefreshGitBranch()
  let g:ra_git_branch_name = substitute(system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'"), '\n', '', 'g')
  let g:ra_git_branch_fetched = 1
endfunction

function! RAGitBranch()
  if !g:ra_git_branch_fetched
    RARefreshGitBranch()
  endif

  if g:ra_git_branch_name == ""
    return ""
  else
    return " " . g:ra_git_branch_name
  endif
endfunction

function! RAFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! RAFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! RAFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! RAMode()
  let fname = expand('%:t')
  return &ft == 'unite' ? 'Unite' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:ra_lightline_left_separator = ''
let g:ra_lightline_right_separator = ''

if has('gui_running')
  let g:ra_lightline_left_separator = ''
  let g:ra_lightline_right_separator = ''
endif

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'RAGitBranch',
      \   'readonly': 'RAReadonly',
      \   'modified': 'RAModified',
      \   'filename': 'RAFilename',
      \   'fileformat': 'RAFileformat',
      \   'filetype': 'RAFiletype',
      \   'fileencoding': 'RAFileencoding',
      \   'mode': 'RAMode',
      \ },
      \ 'separator': { 'left': g:ra_lightline_left_separator, 'right': g:ra_lightline_right_separator },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

