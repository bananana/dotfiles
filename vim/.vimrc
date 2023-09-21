" Set terminal to 256 color xterm
set t_Co=256 

" Explicitly set shell to bash
let g:is_bash = 1

" Pathogen and plugins
execute pathogen#infect()
filetype plugin indent on

" Get Gnome color scheme
let $gnome_color_scheme = system('gsettings get org.gnome.desktop.interface color-scheme
        \ | tr -d "''"
        \ | tr -d \\n')

" Set vim color scheme based on Gnome color scheme
colorscheme lucius
if $gnome_color_scheme == "default" || "prefer-light"
    LuciusWhite
else
    LuciusBlack
endif

" Status line
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'one', }
autocmd OptionSet background
        \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/one.vim') 
        \ | call lightline#init()  
        \ | call lightline#colorscheme()
        \ | call lightline#update()

" Backup and swap directories
set backupdir=/tmp//,.
set dir=/tmp//,.

" Syntax highlighting
syntax on
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Line numbers 
set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * 
        \ if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * 
        \ if &nu | set nornu | endif
augroup END

" Ruler
set ruler

" Backspace that works with autoindent
set backspace=indent,eol,start

" Cursor line
"hi CursorLine   cterm=none ctermbg=238
"hi CursorLineNr cterm=none ctermbg=238

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
map <F4> :ColorToggle<CR>
set pastetoggle=<f5>
