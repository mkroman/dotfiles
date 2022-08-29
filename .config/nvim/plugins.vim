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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

" {{{ Colorschemes
"
" Jellybeans colorscheme
Plug 'nanotech/jellybeans.vim'

" Alduin colorscheme
Plug 'AlessandroYorba/Alduin'

" Challenger deep colorscheme
Plug 'challenger-deep-theme/vim'
" }}}

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
Plug 'maxmellon/vim-jsx-pretty'

Plug 'HerringtonDarkholme/yats.vim'

" Asynchronus live grepping
Plug 'wsdjeg/FlyGrep.vim'

" Tridactylrc syntax highlighting
Plug 'tridactyl/vim-tridactyl'

" org-mode for vim
Plug 'jceb/vim-orgmode'

" speeddating is used by vim-orgmode
Plug 'tpope/vim-speeddating'

Plug 'inkarkat/vim-SyntaxRange'

" Markdown syntax and preview
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" Enhanced vim integration
Plug 'jreybert/vimagit'

" Snippets
Plug 'honza/vim-snippets'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'junegunn/vim-easy-align'

Plug 'efabens/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'branch': 'versions-bumps' }

" Initialize plugin system
call plug#end()
