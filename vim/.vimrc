" Requires vim 7.3+

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Don't need vi compatability; modelines is a security flaw.
set nocompatible
set modelines=0

" Tab/Indent Settings
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Display Settings
colorscheme zenburn " The theme to load.
set cursorline " Highlights current line.
set hidden 
set laststatus=2 " Permanently enables status line.
set relativenumber " Shows relative to cursor line numbers instead of actual.
set ruler " Enables the ruler.
set scrolloff=3 " Acts as a line buffer between the top/bottom of the screen.
set showmode " Shows which mode you are in.
set showcmd " Shows the last command.
set ttyfast " Enables quicker scrolling.
set wildmode=list:longest " Tells the above how to act.
set wildmenu " Improves vims file opening auto complete.
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class "Get out of my wildmenu!
syntax enable " Enable syntax highlighting!

" File Settings
set encoding=utf-8
set undofile " Creates .un~ files that contain undo information.



set t_Co=256
set tw=80
set nowrap
set number

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
map <silent> <C-N> :noh<CR>


" python syntax check
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
