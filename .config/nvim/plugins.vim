call plug#begin('~/.local/share/nvim/plugged')

" Use for browsing tags in source files
Plug 'majutsushi/tagbar'

" Use a.vim for alternating between header and source files
Plug 'vim-scripts/a.vim'

" Use ctrl+p for navigating files
Plug 'ctrlpvim/ctrlp.vim'

" Use vim-surround for closing parantheses, braces, etc
Plug 'tpope/vim-surround'

" Use vim-fugitive for git integration
Plug 'tpope/vim-fugitive'

" Use vim-rspec for rspec integration
Plug 'thoughtbot/vim-rspec'

" Use unite for whatever
Plug 'Shougo/unite.vim'

" Use vimfiler for file exploration
" Plug 'Shougo/vimfiler'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Use vim-coffee-script for coffee-script syntax highlighting
Plug 'kchmck/vim-coffee-script'

" Use vim-crystal for Crystal syntax highlighting
Plug 'rhysd/vim-crystal'

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

" Jellybeans colorscheme
Plug 'nanotech/jellybeans.vim'

" Add a bunch of color schemes
Plug 'chriskempson/base16-vim'

" TOML syntax support
Plug 'cespare/vim-toml'

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
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fatih/vim-go'

  " if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

let g:deoplete#enable_at_startup = 1

Plug 'tibabit/vim-templates'

Plug 'zchee/vim-flatbuffers'

" Use vim-javascript for improved syntax highlighting and indentation
Plug 'pangloss/vim-javascript'

Plug 'HerringtonDarkholme/yats.vim'

" Asynchronus live grepping
Plug 'wsdjeg/FlyGrep.vim'

" Tridactylrc syntax highlighting
Plug 'tridactyl/vim-tridactyl'

" Initialize plugin system
call plug#end()
