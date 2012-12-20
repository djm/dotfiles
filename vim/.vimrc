" Requires vim 7.3+
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Add filetypes to syntax highlighting
au BufNewFile,BufRead *.dump set filetype=sql
au BufNewFile,BufRead *.sass set filetype=sass
au BufNewFile,BufRead *.scss set filetype=scss
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.wsgi set filetype=python
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead *.j2 set filetype=html

" Core/Random Settings
let mapleader = ","

" Key Remaps
inoremap <F1> <ESC> " Remaps stupid help key to Esc
nnoremap <F1> <ESC> " in all modes.
vnoremap <F1> <ESC>
inoremap :W :w 
nnoremap :W :w
vnoremap :W :w
" Disable arrow keys - raaah
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


" Tab/Window Switching Remaps
nnoremap <C-h> <C-w>h " Next four lines control switching split
nnoremap <C-j> <C-w>j " windows. Remap Caps lock to control to 
nnoremap <C-k> <C-w>k " make this even easier.
nnoremap <C-l> <C-w>l
nnoremap <C-left> :tabp<CR> " Previous tab.
nnoremap <C-right> :tabn<CR> " Next tab.

" 3rd Party Plugin Mapping
nnoremap <F5> :GundoToggle<CR> " gundo
let g:ctrlp_map = '<leader>p' " ctrl-p
let g:ctrlp_cmd = 'CtrlPMixed' " ctrl-p
let g:ctrlp_working_path_mode = 2

" Don't need vi compatability; modelines is a security flaw.
set nocompatible
set modelines=0

" File Settings
set encoding=utf-8
if exists("&undofile")
    set undofile " Creates .un~ files that contain undo information.
    set undodir=~/.vim-undo/ " Sets location of undo files directory.
endif
au FocusLost * :wa " Saves file automatically on losing focus.

" Tab/Indent Settings
set autoindent
set backspace=indent,eol,start
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Text Width & Wrapping Settings
set wrap
set textwidth=79
set formatoptions=qrn1
if exists("&colorcolumn")
    set colorcolumn=80
endif

" Colour & Theme Settings
set t_Co=256 " 256 colours support. NB: Before theme.
colorscheme molokai
"colorscheme zenburn
match Todo /\s\+$/ "Highlight trailing whitespace

" Display Settings
"
set cursorline " Highlights current line.
set hidden 
set laststatus=2 " Permanently enables status line.
if exists("&relativenumber")
    set relativenumber " Shows relative to cursor line numbers instead of actual.
endif
set ruler " Enables the ruler.
set scrolloff=5 " Acts as a line buffer between the top/bottom of the screen.
set showmode " Shows which mode you are in.
set showcmd " Shows the last command.
set ttyfast " Enables quicker scrolling.
set wildmode=list:longest " Tells the above how to act.
set wildmenu " Improves vims file opening auto complete.
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class " Get out of my wildmenu!
syntax enable " Enable syntax highlighting!

" Paste settings
set pastetoggle=<F2>

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
nnoremap <leader>n :call NumberToggle()<CR> " n = toggles relative line numbers on & off.
nnoremap <leader>F :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR> " Fixes ^M line endings.

" Syntastic Settings
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html'] }
let g:syntastic_auto_loc_list=1

""""""""""""
" Functions
""""""""""""

function! NumberToggle()
" Toggles relative line numbers in a 
" backwards compatible way.
    if exists("&rnu")
        if &number
            setlocal relativenumber
        else
            setlocal number
        endif
    else
        setlocal nonumber
    endif
endfunction 
