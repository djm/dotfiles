{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    # EDITOR is set via sessionVariables in shell.nix

    plugins = with pkgs.vimPlugins; [
      # Colorschemes
      molokai

      # Navigation & search
      ctrlp-vim
      vim-vinegar

      # Git
      vim-fugitive

      # UI
      vim-airline

      # Syntax & languages
      vim-javascript
      vim-go
      vim-elixir
      vim-css-color

      # Editing
      vim-better-whitespace
      vim-surround
    ];

    settings = {
      # Display
      number = true;
      relativenumber = true;

      # Indentation
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;

      # Search
      ignorecase = true;
      smartcase = true;

      # Misc
      hidden = true;
      mouse = "a";
      undofile = true;
      undodir = [ "~/.vim-undo/" ];
    };

    extraConfig = ''
      " Settings not covered by programs.vim.settings
      set nocompatible
      filetype plugin indent on
      syntax on
      set t_Co=256
      colorscheme molokai

      set autoread
      set clipboard=unnamed
      set encoding=utf-8
      set laststatus=2
      set nowrap
      set scrolloff=5
      set showcmd
      set sidescroll=3
      set splitright
      set wildmenu
      set wildmode=list:longest
      set wildignore=*.pyc
      set modelines=0
      set pastetoggle=<F2>
      set cursorline
      set ruler
      set showmode
      set ttyfast
      set backspace=2
      set cindent
      set smarttab
      set softtabstop=4
      set showmatch
      set hlsearch
      set incsearch
      set gdefault
      set guioptions-=m
      set guioptions-=T

      " File type associations
      au BufNewFile,BufRead *.dump set filetype=sql
      au BufNewFile,BufRead *.wsgi set filetype=python
      au BufNewFile,BufRead Vagrantfile set filetype=ruby
      au BufNewFile,BufRead *.j2 set filetype=html
      au BufNewFile,BufRead *.md set filetype=markdown

      au FocusLost * :wa

      " Leader key
      nnoremap <space> <nop>
      let mapleader = "\<space>"

      " Better search
      nnoremap / /\v
      vnoremap / /\v

      " Disable highlighting of last search
      nnoremap <leader>, :noh<CR>

      " Remap F1 to ESC
      inoremap <F1> <ESC>
      nnoremap <F1> <ESC>
      vnoremap <F1> <ESC>

      " Fat-finger fixes
      command WQ wq
      command Wq wq
      command W w
      command Q q

      " Quick escape from insert mode
      imap jk <Esc>

      " Semicolon to colon
      noremap ; :

      " Prevent overwriting default register
      vnoremap x "_x
      vnoremap c "_c
      vnoremap p "_dP

      " Buffer navigation
      noremap <C-J> :bp<CR>
      noremap <C-K> :bn<CR>
      noremap <Leader>d :bd!<CR>:bp<CR>

      " Split navigation
      noremap <C-h> <C-w>h
      noremap <C-l> <C-w>l
      noremap <C-j> <C-w>j
      noremap <C-k> <C-w>k

      " Highlight trailing whitespace
      match Todo /\s\+$/

      " Turn off bells
      set noerrorbells visualbell t_vb=
      autocmd GUIEnter * set visualbell t_vb=

      " Toggle relative numbers
      autocmd InsertEnter * silent! :set norelativenumber number
      autocmd InsertLeave,BufNewFile,VimEnter * silent! :set relativenumber

      " Remove trailing whitespace on write
      augroup whitespace
          autocmd!
          autocmd BufWritePre * :%s/\s\+$//e
          autocmd BufWritePre * :%s/\($\n\s*\)\+\%$//e
      augroup END

      " Fugitive mappings
      nnoremap <leader>gs :Gstatus<CR>
      nnoremap <leader>gd :Gdiff<CR>
      nnoremap <leader>gb :Gblame<CR>
      nnoremap <leader>gmv :Gmove<CR>
      nnoremap <leader>gc :Gcommit<CR>
      nnoremap <leader>gp :Git push<CR>

      " Split and swap
      nnoremap <leader>s <C-w>v<C-w>l

      " Delete file on disk but keep buffer
      nnoremap <leader>rm :call delete(expand('%'))<CR>

      " Tab spacing shortcuts
      nnoremap <leader>2 :setlocal sw=2 ts=2 sts=2 expandtab<CR>
      nnoremap <leader>4 :setlocal sw=4 ts=4 sts=4 expandtab<CR>
      nnoremap <leader><tab> :setlocal sw=4 ts=4 sts=4 noexpandtab<CR>

      " Vim-airline
      let g:airline#extensions#tabline#enabled = 1

      " Ctrl-p
      let g:ctrlp_map = '<leader>pf'
      let g:ctrlp_cmd = 'CtrlPMixed'
      let g:ctrlp_working_path_mode = 'r'
      let g:ctrlp_use_caching = 200

      " Column toggle
      function! ColumnToggle()
          if exists("&colorcolumn")
              set colorcolumn=80
          endif
      endfunction
      nnoremap <leader>c :call ColumnToggle()<CR>

      " Number toggle
      function! NumberToggle()
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
      nnoremap <leader>n :call NumberToggle()<CR>

      " Fix ^M line endings
      nnoremap <leader>F :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>:w<CR>
    '';
  };
}
