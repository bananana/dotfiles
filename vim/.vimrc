" Set terminal to 256 color xterm
set t_Co=256 

" Pathogen and plugins
execute pathogen#infect()
filetype plugin indent on

" Enable color scheme
colorscheme lucius
LuciusWhite

" Status line
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ }

" Turn syntax highlighting on
syntax on
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Line numbers 
set number

" Ruler
set ruler

" Backspace that works with autoindent
set backspace=indent,eol,start

" Cursor line
hi CursorLine   cterm=none ctermbg=229 ctermfg=none
augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Show matching brackets, braces and parenthesis
set showmatch

" Search 
set ignorecase
set smartcase
set incsearch
set hlsearch

" Tab completion to match bash
set wildmode=longest,list

" Easy expansion of the active file directory
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent

" Window splitting
set splitbelow
set splitright

" Convenient command to see the difference betweeen the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" Key mappings
map <C-n> :NERDTreeToggle<CR>
map <C-j> <C-W>j
map <C-K> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <silent> <S-j> :resize -5<CR>
map <silent> <S-k> :resize +5<CR>
map <silent> <S-h> :vertical resize -5<CR>
map <silent> <S-l> :vertical resize +5<CR>

" Use F5 to toggle paste mode
set pastetoggle=<f5>
