" vim:foldmethod=marker:foldlevel=0

" vim-plug {{{
call plug#begin()

" syntax highlighting
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'tikhomirov/vim-glsl'

" auto complete
Plug 'nvie/vim-flake8'

" navigation/search file
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rking/ag.vim'
Plug 'dkprice/vim-easygrep'

" Colour themes
Plug 'jacoborus/tender.vim'
Plug 'frazrepo/vim-rainbow'

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

call plug#end()
" }}} vim-plug

" Colours {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable " enable syntax processing
colorscheme tender
" set background=dark
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
nnoremap <c-p> :FZF<CR>

" }}} Leader & Mappings

" NERDTree {{{
let NERDTreeShowHidden=1
let NERDTreeIgnore= ['\.pyc$', '__pycache__']
" }}} NerdTree

" Airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='tender'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
" }}} Airline

" YCM {{{
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'gitcommit': 1,
    \ 'python': 1
    \}
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's

" }}}


" LanguageClient_neovim {{{
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" }}}

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

autocmd FileType python setlocal tabstop=4
autocmd FileType rust setlocal tabstop=4
" }}} Filetypes
