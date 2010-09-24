" Requires vim 7.3+

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Core/Random Settings
let mapleader = ","

" Remaps
inoremap <F1> <ESC> " Remaps stupid help key to Esc
nnoremap <F1> <ESC> " in all modes.
vnoremap <F1> <ESC>
nnoremap <C-h> <C-w>h " Next four lines control switching split
nnoremap <C-j> <C-w>j " windows. Remap Caps lock to control to 
nnoremap <C-k> <C-w>k " make this even easier.
nnoremap <C-l> <C-w>l
"nnoremap j gj " More sensible caret
"nnoremap k gk " movement in normal mode.

" Don't need vi compatability; modelines is a security flaw.
set nocompatible
set modelines=0

" File Settings
set encoding=utf-8
set undofile " Creates .un~ files that contain undo information.
set undodir=~/.vim-undo/ " Sets location of undo files directory.
au FocusLost * :wa " Saves file automatically on losing focus.

" Tab/Indent Settings
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Text Width & Wrapping Settings
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Colour & Theme Settings
set t_Co=256 " 256 colours support. NB: Before theme.
colorscheme molokai
"colorscheme zenburn

" Display Settings
set cursorline " Highlights current line.
set hidden 
set laststatus=2 " Permanently enables status line.
set relativenumber " Shows relative to cursor line numbers instead of actual.
set ruler " Enables the ruler.
set scrolloff=5 " Acts as a line buffer between the top/bottom of the screen.
set showmode " Shows which mode you are in.
set showcmd " Shows the last command.
set ttyfast " Enables quicker scrolling.
set wildmode=list:longest " Tells the above how to act.
set wildmenu " Improves vims file opening auto complete.
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class " Get out of my wildmenu!
syntax enable " Enable syntax highlighting!

" Search
nnoremap / /\v
vnoremap / /\v " Better regex handling
set gdefault " Uses global line replacement by default
set ignorecase " Case insensitive matching if using lowercase.
set smartcase " If you search with an upper case character, search becomes case sensitive.
set hlsearch " Next 3 lines handle highlighting while you type.
set incsearch
set showmatch
nnoremap <leader><space> :noh<cr> " Leader + space to remove search highlighting.
nnoremap <tab> % " Remaps tab to match bracket pairs
vnoremap <tab> %

" Leader Functions
nnoremap <leader>s <C-w>v<C-w>l " s = Split window and swap to it.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR> " W = Strip all trailing whitespace.
nnoremap <leader>sortcss ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR> " sortcss = Sort all CSS properties.
nnoremap <leader>v V`] " v = Visually selects just-pasted text.

" Python Specifics
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
