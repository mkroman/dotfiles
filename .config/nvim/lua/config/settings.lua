-- Disable distribution plugins
vim.g.loaded_sql_completion = 1
vim.g.omni_sql_no_default_maps = 1
vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_experimental_template_highlight = 1

-- Automatically format rust code on save
-- vim.g.rustfmt_autosave = 1

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.completeopt = "menuone,noinsert,noselect"
-- Set the directory for swapfiles etc.
-- set directory^=$HOME/.local/share/nvim/tmp//
-- vim.opt.directory:prepend(vim.fn.expand('$HOME/.local/share/nvim/tmp//'))
-- Set the minimum number of lines displayed above and below the current line
-- when scrolling
vim.opt.scrolloff = 5
-- Increase the command-mode history size
vim.opt.history = 512
-- Default to unix file format and line endings
vim.opt.fileformat = 'unix'
-- Create new splits on the right side of the active window.
vim.opt.splitright = true
-- Change indentation levels to two spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- Enable tab-completion of words in insert mode
-- vim.opt.wildmode = { list = 'longest' }
-- Ignore common binary file types
vim.opt.wildignore = { '+=*.so', '*.zip', '*.pdf', '*.a', '*.swp', '.git', '.svn', 'target', '*.3', '*.o' }
-- Enable the wildmenu
vim.opt.wildmenu = true
-- Always show the signcolumn
vim.opt.signcolumn = 'yes'
-- Turn off case sensivity and turn on smart case searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Highlight search terms (even dynamically)
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Shorten the “press ENTER to …” message
vim.opt.shortmess = 'atIc'
-- Turn off the visual bell
vim.opt.visualbell = false
-- Turn on automatic, smart indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
-- Disable word-wrapping by default
vim.opt.wrap = false
-- Show line numbers
vim.opt.number = true
-- Highlight the cursor line
vim.opt.cursorline = true
-- Enable TextMate-style invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ' }
-- Don't write backup files
vim.opt.backup = false
vim.opt.writebackup = false
-- Write the swap much more often, this will make diagnostic messages more useful
vim.opt.updatetime = 300
-- Key-map for pasting large amounts of text
-- vim.opt.pastetoggle = '<F2>'
-- Show the status line
vim.opt.laststatus = 2
-- Enable folding using {{{ and }}}
vim.opt.foldenable = true
vim.opt.foldmethod = 'marker'
vim.opt.foldmarker = '{{{,}}}'
-- Print solid (unicode) lines for vertical splits
-- vim.opt.fillchars = { vert: ' ' }
-- Non-obnoxious wrapping
vim.opt.textwidth = 80
vim.opt.formatoptions = 'cq'
vim.opt.wrapmargin = 0
-- Enable full mouse support
vim.opt.mouse = 'a'
-- C/C++ code formatting
vim.opt.cinoptions = 'g0{0}0N-s(s'
-- Show filename, language and col/row in statusline
vim.opt.statusline = '%f %h%m%r%y%=%c,%l/%L %P'
-- Don't redraw the screen while executing macros
vim.opt.lazyredraw = true
-- Disable color column.
vim.opt.colorcolumn = '0'
