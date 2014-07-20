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

" . in visual mode
xnoremap . :normal .<CR>

" Repeats macro on every line
xnoremap @ :normal@

" Faster line completion
imap <C-L> <C-X><C-L>

" Same as C-O/C-I but centers the text
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz

" Command Mode maps
" Heresy.
cnoremap <C-A> <home>
cnoremap <C-E> <end>
cnoremap <C-P> <up>
cnoremap <C-N> <down>

" Do not exit visual mode when shifting
xnoremap <silent> > >gv
xnoremap <silent> < <gv

" Visual Block mode is far more useful that Visual mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v

" Select the entire file
nnoremap <Leader>a :keepjumps normal ggVG<CR>

" Remap U to nothing, I hate U!
nnoremap U <Nop>

" Keep search matches in the middle of the window
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Don't move on */#
nnoremap <silent>* *zz
nnoremap <silent># #zz

" Keep cursor joining lines
nnoremap J mzJ`z

" _ : Quick horizontal splits
nnoremap _ :sp<CR>

" | : Quick vertical splits
nnoremap <bar> :vsp<CR>

" Movement through splits
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Next/Previous buffer
nnoremap <C-E> :bnext<CR>
nnoremap <C-Space> <C-^>
nnoremap <C-T> :tabnext<CR>
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

" Select the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Remap H and L to beggining and end of the line
nnoremap <expr> <silent> H col(".") == match(getline("."),"\S")+1 ? "0" : "^"
xnoremap <expr> <silent> H col(".") == match(getline("."),"\S")+1 ? "0" : "^"
nnoremap L $
xnoremap L $h

" Make Y consistent with C and D
nnoremap Y y$

" Easier search
nnoremap <Leader>s :%s//g<Left><Left>
xnoremap <Leader>s :s//g<Left><Left>
nnoremap <LocalLeader>s :%s/<C-R>=expand("<cword>")<CR>//g<Left><Left>
nnoremap <LocalLeader>ss :%s/<C-R>=expand("<cword>")<CR>/<C-R>=expand("<cword>")<CR>/g<Left><Left>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
