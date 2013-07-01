" Vundle Stuff
" -----------------------------------------------------------------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"  Colorschemes
Bundle 'nanotech/jellybeans.vim'
Bundle 'flazz/vim-colorschemes'

"  Plugins
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'


" Display
" -----------------------------------------------------------------------------
" set number
" set foldcolumn=2              " display up to 4 folds
" set nowrap                    " Prevent wrapping
set title                       " display title in X.
colorscheme jellybeans



" Vim Settings
" -----------------------------------------------------------------------------
filetype plugin indent on       " required
set nocompatible                " be iMproved
filetype off                    " vundle required

set encoding=utf-8              " use UTF-8
set t_Co=256                    " 256 colours
set background=dark             " the darker the better
syntax on                       " syntax highlighting



" Powerline specific
" -----------------------------------------------------------------------------
set laststatus=2                " always show status bar
set cmdheight=2                 " set cmd height to 2
let g:Powerline_symbols = 'fancy'



" Indentation settings
" -----------------------------------------------------------------------------
set autoindent                  " always set autoindenting on
set shiftwidth=4                " Force indentation to be 4 spaces
set tabstop=4                   "          -- idem --
set list                        " EOL, trailing spaces, tabs: show them.
set lcs=tab:├─                  " Tabs are shown as ├──
set lcs+=trail:␣                " Show trailing spaces as ␣
set expandtab                   " always expand tabs to spaces



" Visual Mode settings
" -----------------------------------------------------------------------------
set hlsearch                    " Hightlight searches
set ignorecase                  " Ignore case when searching
set smartcase                   " Override the ignorecase when search
                                " contains upper letters
vnoremap < <gv                  " indent '>' multiple times in visual mode
vnoremap > >gv                  " indent '<' multiple times in visual mode
nnoremap n nzz                  " on next find center screen



" Code Style settings
" -----------------------------------------------------------------------------
"
" Folding
"
set foldmethod=indent           " Folding method
set foldlevel=99                " Folding level
nnoremap <space> za             " Open up folding
vnoremap <space> zf             " Close folding
"
" Text Bubbling (http://vimcasts.org/episodes/bubbling-text/)
"
nmap <C-Up>   ddkP              " Single line up
nmap <C-Down> ddp               " Single line down
vmap <C-Up>   xkP`[V`]          " Visual mode multiple lines up
vmap <C-Down> xp`[V`]           " Visual mode multiple lines down



" python-mode settings
" -----------------------------------------------------------------------------
let g:pymode_folding = 1



" Keyboard maps
" -----------------------------------------------------------------------------
set pastetoggle=<F2>              " F2 for paste mode
nnoremap <F3> :set hlsearch!<CR>  " Activate or disactive Search Highlighting
let mapleader = ","               " , is easier to reach than the default
map <Leader>a ggVG                " select all
vmap Q gq                         " wrap 80col paragraph vertically



" Compile RestructeredText with rst2html
" -----------------------------------------------------------------------------
function! Compilerst()
    execute 'silent !rst2html % > /tmp/rsttemp.html'
    execute 'silent !firefox /tmp/rsttemp.html &'
    execute 'redraw!'
endfunction
nnoremap <F7> :call Compilerst()<CR>
