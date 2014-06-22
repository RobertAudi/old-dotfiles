function! RAModified()
  return &filetype =~ "help" ? "" : &modified ? "+" : &modifiable ? "" : "-"
endfunction

function! RAReadonly()
  return &filetype !~? "help" && &readonly ? "" : ""
endfunction

function! RAFilename()
  let l:fname = expand("%:t")

  return &filetype == "unite" ? unite#get_status_string() :
        \ &filetype == "easytree" ? fnamemodify(getcwd(), ":t") :
        \ l:fname =~ "__CS__" ? "" :
        \ ("" != RAReadonly() ? RAReadonly() . " " : "") .
        \ ("" != l:fname ? l:fname : "[No Name]") .
        \ ("" != RAModified() ? " " . RAModified() : "")
endfunction

function! RAGitBranch()
  let l:ra_git_branch = gitbranch#name()

  if l:ra_git_branch == ""
    return ""
  else
    return " " . l:ra_git_branch
  endif
endfunction

function! RAFileformat()
  return winwidth(0) > 70 ? &fileformat : ""
endfunction

function! RAFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : "no ft") : ""
endfunction

function! RAFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ""
endfunction

function! RAMode()
  let l:fname = expand("%:t")

  return l:fname =~ "__CS__" ? ctrlspace#statusline_mode_segment() :
        \ &filetype == "unite" ? "Unite" :
        \ &filetype == "easytree" ? "EasyTree" :
        \ winwidth(0) > 60 ? lightline#mode() : ""
endfunction

let g:ra_lightline_left_separator = ""
let g:ra_lightline_right_separator = ""

if has("gui_running")
  let g:ra_lightline_left_separator = ""
  let g:ra_lightline_right_separator = ""
endif

let g:lightline = {
      \ "colorscheme": "jellybeans",
      \ "active": {
      \   "left": [ [ "mode", "paste" ], [ "gitbranch", "filename" ] ],
      \   "right": [ [ "lineinfo" ], ["percent"], [ "fileformat", "fileencoding", "filetype" ] ]
      \ },
      \ "component_function": {
      \   "gitbranch": "RAGitBranch",
      \   "readonly": "RAReadonly",
      \   "modified": "RAModified",
      \   "filename": "RAFilename",
      \   "fileformat": "RAFileformat",
      \   "filetype": "RAFiletype",
      \   "fileencoding": "RAFileencoding",
      \   "mode": "RAMode",
      \ },
      \ "separator": { "left": g:ra_lightline_left_separator, "right": g:ra_lightline_right_separator },
      \ "subseparator": { "left": "", "right": "" }
      \ }

