" Map leaders
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"
let g:maplocalleader = "\\"

" No Help, please
nmap <F1> <Esc>

" Disable Ex mode
" Instead use Q to reapeat the last macro
nnoremap Q @@

" Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" Yank and go to end of selection
xnoremap y y`]

" Paste in visual mode should not replace the default register with the
" deleted text
xnoremap p "_dP

" . in visual mode
xnoremap . :normal .<CR>

" Repeats macro on every line
xnoremap @ :normal@

" Faster line completion
imap <C-L> <C-X><C-L>

" Isolate a line
nnoremap <leader><space><space> O<C-O>j<C-O>o<C-O>k<esc>

" Isolate Visual selection
xnoremap <leader><space><space> dO<cr><esc>P

" Same as C-O/C-I but centers the text
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz

" Bubble single lines
nnoremap <Up> ddkP
nnoremap <Down> ddp

" Bubble multiple lines
xnoremap <Up> xkP`[V`]
xnoremap <Down> xp`[V`]

" Moves the character under the cursor to the end of the line.
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

" Command Mode maps
" Heresy.
cnoremap <C-A> <home>
cnoremap <C-E> <end>
cnoremap <C-P> <up>
cnoremap <C-N> <down>

" Do not exit visual mode when shifting
xnoremap > >gv
xnoremap < <gv

" Visual Block mode is far more useful that Visual mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v

" Select the entire file
nnoremap <Leader>a :keepjumps normal ggVG<CR>

" Yank entire buffer with gy
nnoremap gy :%y+<CR>

" Create newlines without entering insert mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" Remap U to nothing, I hate U!
nnoremap U <Nop>

" Keep search matches in the middle of the window
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't move on */#
nnoremap <silent>* *zz
nnoremap <silent># #zz

" _ : Quick horizontal splits
nnoremap _ :sp<CR>

" | : Quick vertical splits
nnoremap <bar> :vsp<CR>

" Movement through splits
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Search for selected text, forwards or backwards.
xnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
xnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Next/Previous buffer
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>
nnoremap <C-E> :tabnext<CR>
nnoremap <Leader>e :tabprevious<CR>
nnoremap <Leader>nt :tabnew<CR>

" Opens an edit command with the path of the currently edited file filled in
nmap <LocalLeader>e :e <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>ee :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <LocalLeader>te :tabe <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>tee :tabe <C-R>=expand("%:p:h") . "/" <CR>
nmap <LocalLeader>sp :sp <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>spp :sp <C-R>=expand("%:p:h") . "/" <CR>
nmap <LocalLeader>vsp :vsp <C-R>=getcwd() . "/" <CR>
nmap <LocalLeader>vspp :vsp <C-R>=expand("%:p:h") . "/" <CR>


nmap <Leader>t :tabe <C-R>=getcwd() . "/" <CR>
nmap <Leader>tt :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Uppercase!
inoremap <C-U> <esc>gUiwea

" Select (linewise) the text you just pasted.
nnoremap <leader>v V`]

" Auto-indent the code just pasted
nnoremap <LocalLeader>] V`]=

" Select the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Remap H and L to beggining and end of the line
nnoremap <expr> <silent> H col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
xnoremap <expr> <silent> H col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
nnoremap L $
xnoremap L $h

" Make Y consistent with C and D
nnoremap Y y$

" Easier search
nnoremap <Leader>s :%s//g<Left><Left>
xnoremap <Leader>s :s//g<Left><Left>
nnoremap <LocalLeader>s :%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>

" Rename a file easily
nnoremap <LocalLeader>rf :call RenameFile()<CR>
