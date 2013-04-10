" --------------------------+
"        General           |
"--------------------------+

let g:SESSION_DIR   = $HOME.'/.cache/vim/sessions'

if finddir(g:SESSION_DIR) == ''
    silent call mkdir(g:SESSION_DIR, "p")
endif

"pathogen
let g:pathogen_disabled = []
if !has('gui_running')
   call add(g:pathogen_disabled, 'powerline')
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" set <leader> key 
let mapleader = ","
let g:mapleader = ","

" autoreload vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" gundo 
nnoremap <F6> :GundoToggle<CR>

" file options
set fileencodings=utf8
set encoding=utf8 nobomb " utf-8 with out BOM
set termencoding=utf-8 " default text encoding
set ff=unix " default file format

" not compatible with the old-fashion vi mode
set nocompatible

" Sessions
fun! SessionRead(name)
    let s:name = g:SESSION_DIR.'/'.a:name.'.session'
    if getfsize(s:name) >= 0
        echo "Reading " s:name
        exe 'source '.s:name
        exe 'silent! source '.getcwd().'/.vim/.vimrc'
    else
        echo 'Not find session: '.a:name
    endif
endfun

fun! SessionInput(type)
    let s:name = input(a:type.' session name? ')
    if a:type == 'Save'
        call SessionSave(s:name)
    else
        call nested SessionRead(s:name)
    endif
endfun

fun! SessionSave(name)
    exe "mks! " g:SESSION_DIR.'/'.a:name.'.session'
    echo "Session" a:name "saved"
endfun

"--------------------------+
"        Appearance        |
"--------------------------+
" color shceme
colorscheme molokai
let g:molokai_original=1

" status line
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %{&fileformat}\ [LEN=%L]

" show line numbers
set nu

" Show incomplete commands in statusbar
set showcmd

" always show cursor
set ruler

" command bar height
set ch=2

" highlight syntax
syntax on

" enable highlight
set list

" non-printable characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

" 256 color mode
set t_Co=256

" the first guy to show bracket after entering the second
set showmatch

" show brackets for html
set matchpairs+=<:>

"higlight search result
set hlsearch 


"--------------------------+
"           Misc           |
"--------------------------+
" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>go :Gread<CR>
nnoremap <leader>gpl :Git pull origin master<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpm :Git push origin master<CR>

" C-j in normal mode = <cr>
nnoremap <NL> i<CR><ESC>

" Esc
imap jj <Esc>

" fast use mapping keys
set notimeout

" Not jump on star, only highlight
nnoremap * *N

" Drop hightlight search result
noremap <leader><space> :nohls<CR>

" hide mouse pointer when printing
set mousehide 

" yank to the system register (*) by default
set clipboard=unnamed

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" no *~ backup and swap files
set nobackup
set nowritebackup
set noswapfile

" auto update files
set autoread 

" folding by indentation
set nofoldenable

" set 7 lines to the cursor - when moving vertically using j/k
set so=7 

" enable autoident
set autoindent

" tabs
set expandtab " tab to spaces
set shiftwidth=4 "size of tab
set softtabstop=4
set tabstop=4

" enable smart indent
set smartindent

" Fix <Enter> for comment
set fo+=cr

" Выключаем надоедливый "звонок"
set novisualbell
set t_vb=   

" session options
set sessionoptions=curdir,buffers,tabpages

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" a buffer becomes hidden when it is abandoned
"set hidden

" mouse
set mouse=a
set mousemodel=popup

" long lines
nmap j gj
nmap < DOWN> gj
nmap k gk
nmap < UP> gk

"highlights lines lenght > 80
if exists('+colorcolumn')
    highlight ColorColumn ctermbg=235 guibg=#2c2d27
    highlight CursorLine ctermbg=235 guibg=#2c2d27
    highlight CursorColumn ctermbg=235 guibg=#2c2d27
    let &colorcolumn=join(range(81,999),",")
else
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
end



 if has("autocmd")

        augroup vimrc
        au!
            " Autosave last session
            if has('mksession') 
                au VimLeavePre * :call SessionSave('last')
            endif


        augroup END

    endif

" }}}
"
"
"
"
"
"
"
"--------------------------+
"         Mapping          |
"--------------------------+
"C-q - comment/uncomment (NERD_Comment)
map <C-q> <leader>ci
nmap <C-q> <leader>ci
imap <C-q> <ESC><leader>cii

" PHP documenter script bound to Control-K
autocmd FileType php inoremap <C-K> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-K> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-K> :call PhpDocRange()<CR>

"disable arrows
map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>

" C-c and C-v - Copy/Paste to global clipboard
vmap <C-C> "+yi
imap <C-v> <esc>"+gPi

" C-d - duplicate current line
imap <C-d> <esc>yypi

" fast search and replace word under  cursor
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" F5 - show buffers
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" < & > - indent of blocks
vmap < <gv
vmap > >gv

" auto insert ]
imap [ []<LEFT>

" auto insert }
imap {<CR> {<CR>}<Esc>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" copy current doc - open new tab - paste doc
map <leader>co ggVGy:tabnew<cr>:<cr>pgg

" folding
map <leader>zc :EnablePHPFol<cr>
map <leader>zo :DisablePHPFold<cr>

" input mode map 
inoremap <F9>  <ESC>:Phpcs<CR> 
inoremap <F7> <ESC>:cprev<CR> 
inoremap <F8> <ESC>:cnext<CR> 

"normal mode map 
noremap <F9>  <ESC>:Phpcs<CR> 
noremap <F7> <Esc>:cprev<CR> 
noremap <F8> <ESC>:cnext<CR>

" code sniffer
let g:phpcs_std_list="Zend, PEAR"

" Session UI
nnoremap <Leader>ss :call SessionInput('Save')<CR>
nnoremap <Leader>sr :call SessionInput('Read')<CR>
nnoremap <Leader>sl :call SessionRead('last')<CR>
