set nocompatible
set term=xterm-256color
" set mouse=a

" VIM Plugins (vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')  " Plugins will be installed in this folder

" Visual
Plug 'nanotech/jellybeans.vim'
Plug 'flazz/vim-colorschemes'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'romainl/Apprentice'
Plug 'Glench/Vim-Jinja2-Syntax'

" General Purpose Plugins
Plug 'preservim/nerdtree'
Plug 'ciaranm/detectindent'
Plug 'SirVer/ultisnips'
Plug 'ycm-core/YouCompleteMe'
Plug 'srstevenson/vim-picker'
Plug 'AndrewRadev/linediff.vim'
Plug 'zivyangll/git-blame.vim'
Plug 'christianrondeau/vim-base64'
Plug 'mgedmin/python-imports.vim'
Plug 'tpope/vim-surround'

" Python Plugins
Plug 'dense-analysis/ale'
Plug 'vim-scripts/indentpython.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'morhetz/gruvbox'

" Docker Plugins
Plug 'ekalinin/Dockerfile.vim'

" Vagrant Plugin
Plug 'hashivim/vim-vagrant'

" Vue Plugins
Plug 'posva/vim-vue'

" Rust Plugins
Plug 'rust-lang/rust.vim'

" Openhab Plugins
Plug 'cyberkov/openhab-vim'

" PHP
Plug 'StanAngeloff/php.vim'

" Logstash highlight
Plug 'robbles/logstash.vim'

" Logrotate syntax highlight
Plug 'moon-musick/vim-logrotate'

" Yaml
Plug 'stephpy/vim-yaml'

" RST
Plug 'dhruvasagar/vim-table-mode'

" Yang
Plug 'nathanalderson/yang.vim'

" TOML
Plug 'cespare/vim-toml'

" Nginx
Plug 'chr4/nginx.vim'

call plug#end()


" Display
" -----------------------------------------------------------------------------
set number relativenumber       " display relative numbers
" set foldcolumn=2              " display up to 4 folds
" set nowrap                    " Prevent wrapping
set title                       " display title in X.
set visualbell t_vb=            " disable visualbells completely
set cursorline                  " highlight the current line
set termguicolors               " Enable Truecolor support
"set cursorcolumn               " hightlight the current column
colorscheme apprentice



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

set encoding=utf-8              " use UTF-8
set t_Co=256                    " 256 colours
set background=dark             " the darker the better
set ignorecase                  " ignore case
set smartcase                   " makes it easier to search for vim commands
set wildmode=longest,list,full  " more intuative vim command tab completion
syntax on                       " syntax highlighting



" Airline specific
" -----------------------------------------------------------------------------
set laststatus=2                  " always show status bar
set cmdheight=2                   " set cmd height to 2
let g:airline_powerline_fonts = 1 " Use patched fonts
let g:airline_theme='wombat'      " Airline theme https://github.com/vim-airline/vim-airline/wiki/Screenshots


" Picker Settings
" -----------------------------------------------------------------------------
let g:picker_selector_executable = 'pick'
let g:picker_selector_flags = ''
nmap <unique> <leader>pe <Plug>(PickerEdit)
nmap <unique> <leader>ps <Plug>(PickerSplit)
nmap <unique> <leader>pt <Plug>(PickerTabedit)
nmap <unique> <leader>pd <Plug>(PickerTabdrop)
nmap <unique> <leader>pv <Plug>(PickerVsplit)
nmap <unique> <leader>pb <Plug>(PickerBuffer)
nmap <unique> <leader>ph <Plug>(PickerHelp)


" Indentation settings
" -----------------------------------------------------------------------------
"set autoindent                  " always set autoindenting on
set shiftwidth=4                " Force indentation to be 4 spaces
set tabstop=4                   "          -- idem --
set ffs=unix
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


" Vim Table settings
" -----------------------------------------------------------------------------
let g:table_mode_corner_corner='+'  " RST Table style


" Ultisnippets settings
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"


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
    \   'python': ['isort', 'autopep8', 'black'],
\}
let g:ale_linters = {
    \   'python': ['mypy', 'pylint'],
    \   'shell': ['shellcheck'],
\}

" Don't lint test files
let g:ale_pattern_options = {
    \   'tests\/': {
    \       'ale_linters': ['pylint'],
    \       'ale_fixers': ['isort', 'autopep8']
    \   },
\}

" General Ale Settings
let g:ale_cache_executable_check_failures = 1
let b:ale_python_mypy_use_global = 0
let b:ale_python_pylint_use_global = 0

" Test Type Anotations with strict option
let g:ale_python_mypy_options = '--ignore-missing-imports --strict'

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Format Ale Error Messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] [%linter%: %code%] %s'

" Integrate with vim-airline
let g:airline#extensions#ale#enabled = 1

" Run ALEFix
nnoremap <C-i> :ALEFix<CR>


"
" Git blame setting
" -----------------------------------------------------------------------------
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>



" IndentLine Settings
" -----------------------------------------------------------------------------
let g:indentLine_char = '|'


" YouCompleteMe Settings
" -----------------------------------------------------------------------------
let g:ycm_extra_conf_globlist = ['.ycm_extra_conf.py']
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3


" Keyboard maps
" -----------------------------------------------------------------------------
set pastetoggle=<F2>              " F2 for paste mode
nnoremap <F3> :set hlsearch!<CR>  " Activate or disactive Search Highlighting
let mapleader = ","               " , is easier to reach than the default
map <Leader>    a ggVG            " select all
vmap            Q gq              " wrap 80col paragraph vertically
imap <silent> <C-l> <Plug>(YCMToggleSignatureHelp)



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
autocmd BufRead,BufNewFile *.rst  setlocal tw=80
autocmd BufRead,BufNewFile *.json setlocal tabstop=2 sw=2
autocmd FileType javascript      set tabstop=2 sw=2
autocmd FileType html            set tabstop=2 sw=2
autocmd FileType sh              set tabstop=2 sw=2
autocmd FileType xml             set tabstop=2 sw=2
autocmd FileType vue             set tabstop=2 sw=2
" autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/syntax/yaml.vim

augroup python
    autocmd!
    autocmd FileType python
        \ syn keyword pythonSelf self
        \ | highlight def link pythonSelf Special
augroup end


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
