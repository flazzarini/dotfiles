set nocompatible

" Vundle Stuff
" -----------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("~/.vim/bundle")

" Vundle
Plugin 'gmarik/Vundle.vim'

"  Colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'flazz/vim-colorschemes'

" Plugins
Plugin 'Lokaltog/vim-powerline'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'Konfekt/FastFold'
Plugin 'scrooloose/nerdtree'
" Plugin 'sirver/ultisnips'

" Syntax Plugins
Plugin 'lepture/vim-jinja'
Plugin 'chase/vim-ansible-yaml'
Plugin 'cyberkov/openhab-vim'

call vundle#end()


" Display
" -----------------------------------------------------------------------------
" set number
" set foldcolumn=2              " display up to 4 folds
" set nowrap                    " Prevent wrapping
set title                       " display title in X.
set visualbell t_vb=            " disable visualbells completely
colorscheme jellybeans


" Nerdtree
" -----------------------------------------------------------------------------
" autocmd vimenter * NERDTree         " Autostarts nerdtree
let mapleader = ","                 " , is easier to reach than the default
nmap <leader>ne :NERDTree<cr>       " Shortcut to open Nerdtree
let NERDTreeMapOpenInTab='\r'       " Default open files in Tabs
let NERDTreeMapOpenInTab='<ENTER>'  " Default open files in Tabs

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
set backspace=2                 " make backspace behave like in most other apps



" Visual Mode settings
" -----------------------------------------------------------------------------
set hlsearch                    " Hightlight searches
set ignorecase                  " Ignore case when searching
set smartcase                   " Override the ignorecase when search
                                " contains upper letters
vnoremap < <gv                  " indent '>' multiple times in visual mode
vnoremap > >gv                  " indent '<' multiple times in visual mode
"nnoremap n nzz                  " on next find center screen



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
set completeopt-=preview        " Do not pop up pydoc on completing
let g:pymode_folding = 1
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_mccabe_complexity = 9
let g:pymode_doc = 0
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0



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



" Spell check per filetype
" -----------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.md  setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.rst setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us



" Specific settings for filetypes
" -----------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.rst setlocal tw=80
autocmd FileType javascript set tabstop=2 sw=2


source ~/.vimdb
