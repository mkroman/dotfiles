" Copyright (c) 2019, Mikkel Kroman <mk@maero.dk>
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
" CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


" {{{ Jellybeans overrides
if has('gui_running')
  " GUI overrides
  let g:jellybeans_overrides = {
  \  'background': { 'guibg': '121212' },
  \}
endif
" }}}

if filereadable(expand('~/.config/nvim/plugins.vim'))
  source ~/.config/nvim/plugins.vim
endif

" Mappings:
"
" <leader>/     Clear currently highlighted search results
" <leader>n     Rename the file in the current buffer
" <leader>tn    Create a new tab window
" <leader>tc    Close the active tab window
" <leader>s     Create a new GoldenView split
" <leader>\     Create a new vertical split
" <leader>-     Create a new horizontal split
" <S-j>         Jump 10 lines downwards
" <S-k>         Jump 10 lines upwards
"
if &t_Co > 2 || has('gui_running')
  " Disable the menu, scrollbar, etc.
  set guioptions-=m guioptions-=T guioptions-=e guioptions-=r guioptions-=L

  " Meslo is a customized version of Apple's Menlo font
  set guifont=Fira\ Code\ 9

  if has('gui')
    set guiheadroom=0
  endif

  syntax on

  try
    colorscheme base16-tomorrow-night
    "colorscheme base16-solarized-light
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
  endtry

  if has('gui_running')
    " Set the default window size. 205 columns is enough to have 2 splits that
    " spans 99 columns each.
    set lines=50 columns=209
  endif
endif

if has('autocmd')
  filetype plugin indent on

  " Return to last editing position on launch
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif "
endif 

set termguicolors

" {{{ VIM Configuration

" Set the directory for swapfiles etc.
set directory^=$HOME/.local/share/nvim/tmp//

" Set the minimum number of lines displayed above and below the current line
" when scrolling
set scrolloff=5

" Increase the command-mode history size
set history=512

" Default to unix file format and line endings
set fileformat=unix

" Create new splits on the right side right side of the window
set splitright

" Change indentation levels to two spaces
set expandtab shiftwidth=2 tabstop=2

" Enable tab-completion of words in insert mode
set wildmode=list:longest

" Ignore common and binary file types
set wildignore+=*.so,*.zip,*.pdf,*.a,*.swp,.git,.svn,Build,target,*.3,*.o

" Enable the wildmenu
set wildmenu

" Always show the signcolumn
set signcolumn=yes

" Change the leader key
let mapleader = ","

" Turn off case sensivity and turn on smart case searching
set ignorecase smartcase

" Highlight search terms (even dynamically)
set hlsearch incsearch

" Hide buffers instead of abandoning them
set hidden

" Shorten the “press ENTER to …” message
set shortmess=atIc

" Turn off the audible bell and turn on the visual bell
set novisualbell

" Turn on automatic, smart indentation
set autoindent smartindent

" Turn off word-wrapping
set nowrap

" Turn on line numbers
set number

" Enable cursor-line highlighting
set cursorline

" Enable TextMate-style invisibles
set list listchars=tab:▸\ 

" Don't write backup files
set nobackup nowritebackup

" Write the swap much more often, this will make diagnostic messages more useful
set updatetime=300

" Key-map for pasting large amounts of text
set pastetoggle=<F2>

" Show the status line
set laststatus=2

" Enable folding using {{{ and }}}
set foldenable foldmethod=marker foldmarker={{{,}}}

" Print solid (unicode) lines for vertical splits
set fillchars+=vert:\ 

" Set a 80-character margin
set colorcolumn=0

" Non-obnoxious wrapping
set textwidth=80 formatoptions=cq wrapmargin=0

" Enable full mouse support
set mouse=a

" C/C++ code formatting
set cinoptions=g0{0}0N-s(s

" Show filename, language and col/row in statusline
set statusline=%f\ %h%m%r%y%=%c,%l/%L\ %P

set lazyredraw

let g:loaded_sql_completion = 1
let g:omni_sql_no_default_maps = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" }}}

" {{{ VIM Mappings

" Shortcut for command-mode
nnoremap ; :

" Rename a file by hitting <leader>n
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <silent> <leader>n :call RenameFile()<cr>

" Jump 10 lines at a time
" nmap <S-j> 10j
" nmap <S-k> 10k

" Clear search highlights by pressing double escape
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Moving between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-L> <C-W>l
nmap <C-h> <C-W>h

" Managing tabs
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>
map <leader>tm :tabmove

" Split vertically
nnoremap <leader>\ :vnew<CR>

" Split horizontally
nnoremap <leader>- :new<CR>

" Quick save
map <leader>w :w!<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Edit vim file (“edit vim”)
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

" Reload vim file (“source vim”)
nnoremap <leader>sv :source $MYVIMRC<CR>

" Format the selected paragraph
vmap <leader>l :!par -w80<CR>

" {{ CoC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:coc_snippet_next = '<tab>'

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^="%{coc#status()}%{get(b:,'coc_current_function','')} "

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" }}}
" Plugins
" {{{ Airline

let g:airline_extensions = []
" Settings
" Disable whitespace detection.
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#show_message = 0

" Disable branch info (it slows everything down)
let g:airline#extensions#branch#enabled = 0

" }}}
" {{{ ClangFormat

" Mappings
noremap <leader>F :pyf /usr/share/clang/clang-format.py<CR>
" inoremap <C-i> <c-o>:pyf /usr/share/clang/clang-format.py<CR>

" }}}
" {{{ CtrlP

" Settings
let g:ctrlp_custom_ignore = 'node_modules$\|build$\|tmp$'

" Mappings
nnoremap <C-u> :CtrlPMixed<CR>

" }}}
" {{{ GitGutter

" Settings
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1

" }}}
" {{{ Syntastic

" Settings
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = 'x'
let g:syntastic_style_warning_symbol = '!'
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'passive_filetypes': ['haml'] }

" }}}
" {{{ Tagbar

" Mappings
nnoremap <C-t> :Tagbar<CR>

" }}}
" {{{ UltiSnips

" Mappings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:SuperTabDefaultCompletionType = '<C-n>'

" }}}
" {{{ Defx
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#is_directory() ? defx#do_action('open') : defx#do_action('redraw')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')

  call defx#custom#option('_', {
        \ 'auto_recursive_level': '3',
        \ 'columns': 'indent:icon:filename',
        \ 'split': 'vertical',
        \ 'ignored_files': '.*,./target,Cargo.lock'
        \ })

  call defx#custom#column('filename', {
        \ 'root_marker_highlight': 'Ignore',
        \ })
  
  call defx#custom#column('icon', {
        \ 'directory_icon': '▸',
        \ 'opened_icon': '▾',
        \ 'root_icon': ' ',
        \ })
  
  call defx#custom#column('filename', {
        \ 'min_width': 1,
        \ 'max_width': 40,
        \ })
  
  call defx#custom#column('mark', {
        \ 'readonly_icon': '✗',
        \ 'selected_icon': '✓',
        \ })
endfunction

" }}}
" {{{ VimFiler

" Settings

" Use VimFiler as the default explorer
let g:vimfiler_as_default_explorer = 1

" Change the folder characters
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = ' ▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

" Mappings
nnoremap <silent> <C-e> :Defx -winwidth=30 -direction=topleft<CR>
" nnoremap <silent> <C-e> :Defx -toggle -split=floating<CR>

" }}}
" {{{ ALE
highlight ALEWarning ctermbg=black cterm=bold
" }}}
" {{{ Markdown Preview
" Automatically open a browser window when entering a markdown buffer.
let g:mkdp_auto_start = 0
" Automatically close the browser window when exiting a mrkdown buffer.
let g:mkdp_auto_close = 1
" }}}

" Automatically format the code according to the Rust guidelines when a buffer
" if saved and rust.vim is loaded
let g:rustfmt_autosave = 1

let g:tmpl_author_name = 'Mikkel Kroman'
let g:tmpl_author_email = 'mk@maero.dk'
let g:tmpl_search_paths = ['~/.vim/templates']

map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Test fix for yaml indentation
augroup yaml_fix
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END

autocmd FileType c setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
autocmd FileType python setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
autocmd FileType rust setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
autocmd FileType rust nnoremap <silent> <buffer> gb :CocCommand rust-analyzer.openDocs<CR>
autocmd FileType markdown setlocal nowrap
" Align GitHub-flavored Markdown tables
autocmd FileType markdown,rust vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   ignore_install = { }, -- List of parsers to ignore installing
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = {},  -- list of language that will be disabled
"   },
" }
" EOF

