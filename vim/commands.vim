command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Wqa wqa<bang>
command! -bang WQa wqa<bang>
command! -bang WQA wqa<bang>

" Save and make executable
command! -bang WX w | silent! !chmod a+x %

" Copy the path to the current Dir or Filename
command! -nargs=0 CopyDirPath  let @*=expand('%:p:h')
command! -nargs=0 CopyFilePath let @*=expand('%:p')
