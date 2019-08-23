set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Let Vundle manage itself
" Plug 'gmarik/Vundle.vim'

" Use golden view for good split ratios
" Plugin 'zhaocai/GoldenView.Vim'

" Use for browsing tags in source files
Plug 'majutsushi/tagbar'

" Use a.vim for alternating between header and source files
Plug 'vim-scripts/a.vim'

" Use ctrl+p for navigating files
Plug 'ctrlpvim/ctrlp.vim'

" Use syntastic for syntax linting
" Plugin 'scrooloose/syntastic'

" Use Asynchronous Lint Engine for syntax linting

" Don't use ALE for completion
 " let g:ale_completion_enabled = 0

" Plug 'w0rp/ale'

" Use tcomment for sensible and easy comments
" Plug 'tomtom/tcomment_vim'

" Use vim-airline for a smarter status bar
" Plugin 'bling/vim-airline'

" Use vim-fugitive for git features
" Plug 'tpope/vim-fugitive'

" Use vim-surround for closing parantheses, braces, etc
Plug 'tpope/vim-surround'

" Extend with cmake support
" Plug 'jalcine/cmake.vim'

" Use vim-rspec for rspec integration
Plug 'thoughtbot/vim-rspec'

" Use ultisnips for smart snippets
""Plugin 'SirVer/ultisnips'

" Use YouCompleteMe for tab-completion
" Plugin 'Valloric/YouCompleteMe'

" Use nerdtree for file exploration
"Plugin 'scrooloose/nerdtree'

" Use unite for whatever
Plug 'Shougo/unite.vim'

" Use vimfiler for file exploration
Plug 'Shougo/vimfiler'

" Use vim-snippets for a collection of snippets
" "Plugin 'honza/vim-snippets'

" Use vim-coffee-script for coffee-script syntax highlighting
Plug 'kchmck/vim-coffee-script'

" Use vim-crystal for Crystal syntax highlighting
Plug 'rhysd/vim-crystal'

" Use vim-markdown for markdown syntax highlighting
" Plug 'plasticboy/vim-markdown'

" Use vim-nasm for NASM syntax highlighting
" Plugin 'helino/vim-nasm'

" Use vim-protobuf for protobuf syntax highlighting
Plug 'eventualbuddha/vim-protobuf'

" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

" Use vim-ruby for improved Ruby syntax highlighting
Plug 'vim-ruby/vim-ruby'

" Add Rust support
Plug 'rust-lang/rust.vim'

" Use vim-slim for slim syntax highlighting
Plug 'slim-template/vim-slim'

" Improved C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Add i3 configuration syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax'

" Use vim-indentobject for indenting whole blocks of text
Plug 'austintaylor/vim-indentobject'

" Use tabular for alignment wizardry
Plug 'godlygeek/tabular'

" Use vim-gitgutter to see what has changed
" Plugin 'airblade/vim-gitgutter'

" Solarized color scheme
" Plug 'altercation/vim-colors-solarized'

" Use supertab so that ultisnips will play nice with YCM's tab-completion
" "Plugin 'ervandew/supertab'

" Rust syntax completion
" Plugin 'racer-rust/vim-racer'

" Jellybeans colorscheme
Plug 'nanotech/jellybeans.vim'

" Add a bunch of color schemes
Plug 'chriskempson/base16-vim'

" TOML syntax support
Plug 'cespare/vim-toml'

" Automatically insert license templates when creating new files
" Disabled because it slows down vim when opening new files.
" Plugin 'aperezdc/vim-template'

" Automatically close pairs like [], {} and ()
" Plugin 'jiangmiao/auto-pairs'

" Udev rules syntax support
Plug 'vim-scripts/syntaxudev.vim'

" Smali syntax support
Plug 'kelwin/vim-smali'

" TMUX syntax support
Plug 'tmux-plugins/vim-tmux'

" Jenkinsfile syntax support
Plug 'martinda/Jenkinsfile-vim-syntax'

" Text-object motion for arguments
Plug 'vim-scripts/argtextobj.vim'

" Language Server Protocol support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

Plug 'tibabit/vim-templates'

" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'zchee/vim-flatbuffers'

" Use vim-javascript for improved syntax highlighting and indentation
Plug 'pangloss/vim-javascript'

" Initialize plugin system
call plug#end()
