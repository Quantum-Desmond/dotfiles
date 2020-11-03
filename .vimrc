" vim:foldmethod=marker:foldlevel=0

" vim-plug {{{
call plug#begin()

" syntax highlighting
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" auto complete
Plug 'nvie/vim-flake8'

" navigation/search file
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
Plug 'dkprice/vim-easygrep'

" Colour themes
Plug 'jacoborus/tender.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'dracula/vim'

" notes
Plug 'xolox/vim-misc'

" editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'

" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree'

call plug#end()
" }}} vim-plug

" Colours {{{
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
     set termguicolors
endif

syntax enable " enable syntax processing
" colorscheme tender
colorscheme dracula
set background=dark
" }}} Colours

" Spaces & Indentation {{{
set tabstop=4      " number of viual spaces per TAB
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4   " number of spaces to use for autoindent
set expandtab      " On pressing tab, insert 4 spaces
set autoindent     " tabs are space
set copyindent     " copy indentation from previous line
" }}} Spaces & Indentation

" UI tweaks {{{
set hidden
set number         " show line number
set showcmd        " show command in bottom bar
set wildmenu       " visual autocomplete for command menu
set showmatch      " highlight matching [{()}]
" }}} UI tweaks

" Search {{{
set incsearch                             " search as characters are entered
set hlsearch                              " highlight searches
set ignorecase                            " ignore case when searching
set smartcase                             " ignore case if search pattern is lower case
                                          " case-sensitive otherwise
" }}} Search

" Folding {{{
set foldenable
set foldlevelstart=10   " default folding level when buffer is opened
set foldnestmax=10      " maximum nested fold
set foldmethod=syntax   " fold based on indentation
" }}} Folding

" Leader & Mappings {{{
let mapleader=","       " leader is comma

" edit/reload vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" better esc
inoremap jk <esc>

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" Set ,<space> to remove current highlighting
nnoremap <leader><space> :nohlsearch<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" fast header source switch
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" fzf fuzzy finder
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \}
" }}} Leader & Mappings

" NERDTree {{{
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI=1
let g:NERDTreeIgnore= ['\.pyc$', '__pycache__']
let g:NERDTreeStatusLine = ''

" Automatically close nvim if NERDTree is the only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" }}} NerdTree

" Terminal {{{
" open split panes to the right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+n
function! OpenTerminal()
    split term://zsh
    resize 10
endfunction
nnoremap <C-n> :call OpenTerminal()<CR>
" }}} Terminal

" Panel switching {{{
" use Alt + hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" }}} Panel switching

" Airline {{{
" let g:airline_powerline_fonts=1
let g:airline_powerline_fonts=0
let g:airline_theme='tender'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
" }}} Airline

" Autocomplete {{{
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'gitcommit': 1,
    \ 'python': 1
    \}
let g:ycm_rust_src_path='/home/karl/workspace/rust/src/'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's

let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" }}} Autocomplete

" Flake8 {{{
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
" }}} Flake8

" Rainbow {{{
let g:rainbow_active=1
" }}} Rainbow

" Functions {{{
" trim trailing whitespace on save
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
	%s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()
" }}} Functions

" Filetypes {{{
" set filetype for Vagrantfile to ruby
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

" SenseTalk filetype
autocmd BufRead,BufNewFile *.script set filetype=sensetalk
" }}} Filetypes

