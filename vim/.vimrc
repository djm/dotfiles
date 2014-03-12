set nocompatible
filetype off

" setup and run vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/syntastic'
Bundle 'YankRing.vim'
Bundle 'skammer/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'chase/vim-ansible-yaml'
Bundle 'tpope/vim-fugitive'

filetype plugin indent on

" Add filetypes to syntax highlighting
au BufNewFile,BufRead *.dump set filetype=sql
au BufNewFile,BufRead *.sass set filetype=sass
au BufNewFile,BufRead *.scss set filetype=scss
au BufNewFile,BufRead *.yml,*.yaml set filetype=yaml
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.wsgi set filetype=python
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au BufNewFile,BufRead *.j2 set filetype=html

" Key Remaps
nnoremap <space> <nop>
let mapleader = "\<space>"
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

" modelines is a security flaw.
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

" Spaces for html
autocmd FileType html :setlocal shiftwidth=2 tabstop=2 softtabstop=2 

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
highlight ExtraWhitespace ctermbg=red guibg=red " Highlight trailing space
match ExtraWhitespace /\s\+$/ " Regex for highlighting trailing space

" Turn off visual and sound bells
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

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
" Leader + space to remove search highlighting.
nnoremap <leader>, :noh<cr>
nnoremap <tab> % " Remaps tab to match bracket pairs
vnoremap <tab> %

" Leader Functions
" s = Split window and swap to it.
nnoremap <leader>s <C-w>v<C-w>l
" W = Strip all trailing whitespace.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" sortcss = Sort all CSS properties.
nnoremap <leader>sortcss ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" switches between relative and static line numbering
nnoremap <leader>n :call NumberToggle()<CR>
" Fixes ^M line endings.
nnoremap <leader>F :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR>
" v = insert path to virtualenv package dir.
" Obviously won't work if youre using a project inside vagrant.
nnoremap <leader>v :e $VIRTUAL_ENV/lib/python2.7/site-packages/
" Use leader + number to indicate tab spacing.
nnoremap <leader>2 :setlocal sw=2 ts=2 sts=2<CR>
nnoremap <leader>4 :setlocal sw=4 ts=4 sts=4<CR>

" 3rd Party Plugin Mapping/Settings
" - gundo
nnoremap <leader>g :GundoToggle<CR> " gundo
" - ctrl-p
let g:ctrlp_map = '<leader>o'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'r'
"  -- Swaps controls so default is open in tab.
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
"  -- disables path caching on dirs with small amount of files.
let g:ctrlp_use_caching = 200
" - yankring
let g:yankring_history_file = '.yankring_history'
" - syntastic
let g:syntastic_enable_signs=1
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html'] }
let g:syntastic_auto_loc_list=1
" to edit flake8 args, see ~/.config/flake8
let g:syntastic_python_checkers = ["flake8"]
" - fugitive.vim - git plugin
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gmv :Gmove<CR>
nnoremap <leader>gc :Gcommit<CR>


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
