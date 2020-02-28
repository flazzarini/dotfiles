set nocompatible
set term=screen-256color

" Vundle Stuff
" -----------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin("~/.vim/bundle")

" Vundle
Plugin 'gmarik/Vundle.vim'

"  Colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'flazz/vim-colorschemes'

" Visual
Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'

" General Purpose Plugins
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'

" Python Plugins
Plugin 'python-mode/python-mode'
Plugin 'w0rp/ale'

" Docker Plugins
Plugin 'ekalinin/Dockerfile.vim'

" Vagrant Plugin
Plugin 'vim-vagrant'

" Vue Plugins
Plugin 'posva/vim-vue'

" PHP
Plugin 'StanAngeloff/php.vim'

" Logstash highlight
Plugin 'robbles/logstash.vim'

" Yaml
" Plugin 'stephpy/vim-yaml'

" Disabled Plugins
" Plugin 'lepture/vim-jinja'
" Plugin 'chase/vim-ansible-yaml'
" Plugin 'cyberkov/openhab-vim'

" RST
Plugin 'dhruvasagar/vim-table-mode'

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
set laststatus=2                  " always show status bar
set cmdheight=2                   " set cmd height to 2
let g:airline_powerline_fonts = 1 " Use patched fonts



" Indentation settings
" -----------------------------------------------------------------------------
"set autoindent                  " always set autoindenting on
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
let g:pymode_folding = 0
let g:pymode_lint_checker = ""
let g:pymode_lint_mccabe_complexity = 9
let g:pymode_doc = 0
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_python = 'python3'


" ctrl-p settings
" -----------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 0


"
" Ansible Settings
" -----------------------------------------------------------------------------
let g:anisble_vault_password_file = '~/workspace/ansible/vault_password'


"
" Ale config
" -----------------------------------------------------------------------------
let g:ale_fixers = {
\   'python': ['isort', 'autopep8'],
\}
let g:ale_linters = {
\   'python': ['mypy', 'pylint'],
\}

" Don't lint test files
let g:ale_pattern_options = {
\   'tests\/': {'ale_linters': ['pylint'], 'ale_fixers': ['isort', 'autopep8']},
\}

" Test Type Anotations with strict option
let g:ale_python_mypy_options = '--ignore-missing-imports --strict'

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Format Ale Error Messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] [%linter%: %code%] %s'

" Run ALEFix
nnoremap <C-i> :ALEFix<CR>


" Utlisnippets settings
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" IndentLine Settings
" -----------------------------------------------------------------------------
let g:indentLine_char = '|'



" Keyboard maps
" -----------------------------------------------------------------------------
set pastetoggle=<F2>              " F2 for paste mode
nnoremap <F3> :set hlsearch!<CR>  " Activate or disactive Search Highlighting
let mapleader = ","               " , is easier to reach than the default
map <Leader>    a ggVG            " select all
vmap            Q gq              " wrap 80col paragraph vertically



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
autocmd BufRead,BufNewFile *.in  setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us



" Specific settings for filetypes
" -----------------------------------------------------------------------------
autocmd BufRead,BufNewFile *.rst setlocal tw=80
autocmd FileType javascript      set tabstop=2 sw=2
autocmd FileType html            set tabstop=2 sw=2
autocmd FileType sh              set tabstop=2 sw=2
autocmd FileType xml             set tabstop=2 sw=2
" autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/syntax/yaml.vim


"
" Scripts
" -----------------------------------------------------------------------------

function Header(width, word)
    let a:inserted_word = ' ' . a:word . ' '
    let a:word_width = strlen(a:inserted_word)
    let a:length_before = (a:width - a:word_width) / 2
    let a:hashes_before = repeat('#', a:length_before)
    let a:hashes_after = repeat('#', a:width - (a:word_width + a:length_before))
    let a:hash_line = repeat('#', a:width)
    let a:word_line = a:hashes_before . a:inserted_word . a:hashes_after

    :put =a:hash_line
    :put =a:word_line
    :put =a:hash_line
endfunction

source ~/.vimdb
