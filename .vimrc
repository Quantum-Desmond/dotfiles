syntax enable " enable syntax processing

set tabstop=4 " # of visual spaces per TAB
set softtabstop=4 " # of spaces in tab when editing
set expandtab " tabs are spaces
set showcmd
set autoindent
set visualbell
" set cursorline

filetype indent on
set wildmenu " visual autocomplete for command menu
set showmatch " highlight matching [{()}]

set incsearch " search as characters are entered
set hlsearch " highlight searches

nnoremap <leader><space> :nohlsearch<CR>

let mapleader=","

inoremap jk <esc>

" set filetype for Vagrantfile to ruby
augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

autocmd BufRead,BufNewFile *.script set filetype=sensetalk
