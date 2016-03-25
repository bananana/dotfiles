" Set terminal to 256 color xterm
set t_Co=256 

" Set theme
"colo pablo

" Disable vim-airline, comment these two lines out if you want it.
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'vim-airline')

" Pathogen and plugins
execute pathogen#infect()
syntax on
filetype plugin indent on

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

" Status line
hi StatusLine ctermbg=yellow ctermfg=black

" Line numbers
set number
hi LineNr	cterm=none ctermbg=black ctermfg=none

" Cursor line
set cursorline
autocmd InsertEnter * hi CursorLine cterm=none ctermbg=none ctermfg=none
autocmd InsertLeave * hi CursorLine cterm=none ctermbg=black ctermfg=none
hi CursorLine   cterm=none ctermbg=black ctermfg=none

" Search 
set ignorecase
set smartcase
set incsearch
set hlsearch
hi Search cterm=none ctermbg=white ctermfg=black

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent

" Show matching brackets, braces and parenthesis
set showmatch
hi  MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Convenient command to see the difference betweeen the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif
