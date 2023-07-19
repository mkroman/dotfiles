call plug#begin('~/.local/share/nvim/plugged')

" Use ctrl+p for navigating files
Plug 'ctrlpvim/ctrlp.vim'

" Use vim-surround for closing parantheses, braces, etc
Plug 'tpope/vim-surround'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Improved syntax highlighting for Ruby
Plug 'vim-ruby/vim-ruby'

" Add Rust support
Plug 'rust-lang/rust.vim'

" Improved C++ syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Add i3 configuration syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax'

" Use vim-indentobject for indenting whole blocks of text
Plug 'austintaylor/vim-indentobject'

" {{{ Colorschemes

" Add a bunch of color schemes
Plug 'chriskempson/base16-vim'

" }}}

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fatih/vim-go'

Plug 'tibabit/vim-templates'

" Syntax highlighting for Google Flatbuffers
Plug 'zchee/vim-flatbuffers'

" Use vim-javascript for improved syntax highlighting and indentation
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'HerringtonDarkholme/yats.vim'

" Asynchronus live grepping
Plug 'wsdjeg/FlyGrep.vim'

" Tridactylrc syntax highlighting
Plug 'tridactyl/vim-tridactyl'

" Snippets
Plug 'honza/vim-snippets'

" Visual indentation guides
Plug 'nathanaelkane/vim-indent-guides'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Syntax highlighting for Jsonnet
Plug 'google/vim-jsonnet'

" Syntax highlighting for Ansible
Plug 'pearofducks/ansible-vim', { 'commit': '93798e8c89c441d29d4678da0c0d5e1429eb43b0' }

" Syntax highlighting and integration for Terraform
Plug 'hashivim/vim-terraform'

" Initialize plugin system
call plug#end()
