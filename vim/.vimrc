filetype indent on
set backspace=indent,eol,start
set t_Co=256
set tw=80
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set number

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch
map <silent> <C-N> :noh<CR>

colorscheme zenburn

" python syntax check
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
