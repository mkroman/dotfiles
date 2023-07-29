" Copyright (c) 2022, Mikkel Kroman <mk@maero.dk>
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

" Load nvim plugins.
if filereadable(expand('~/.config/nvim/plugins.vim'))
  source ~/.config/nvim/plugins.vim
endif

" Configure syntax highlighting and colorschemes if the environment supports it.
if &t_Co > 2 || has('gui_running')
  " Enable syntax highlighting.
  syntax on

  try
    colorscheme base16-tomorrow-night
  catch /^Vim\%((\a\+)\)\=:E185/
    " Fall back to the desert colorscheme if the requested wasn't found
    colorscheme desert
  endtry
endif

if has('autocmd')
  filetype plugin indent on

  " Return to last editing position on launch
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif 

set termguicolors

" {{{ VIM Configuration

" Change the leader key
let mapleader = ","

" Set the directory for swapfiles etc.
set directory^=$HOME/.local/share/nvim/tmp//
" Set the minimum number of lines displayed above and below the current line
" when scrolling
set scrolloff=5
" Increase the command-mode history size
set history=512
" Default to unix file format and line endings
set fileformat=unix
" Create new splits on the right side of the active window.
set splitright
" Change indentation levels to two spaces
set expandtab shiftwidth=2 tabstop=2
" Enable tab-completion of words in insert mode
set wildmode=list:longest
" Ignore common binary file types
set wildignore+=*.so,*.zip,*.pdf,*.a,*.swp,.git,.svn,Build,target,*.3,*.o
" Enable the wildmenu
set wildmenu
" Always show the signcolumn
set signcolumn=yes
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
" Non-obnoxious wrapping
set textwidth=80 formatoptions=cq wrapmargin=0
" Enable full mouse support
set mouse=a
" C/C++ code formatting
set cinoptions=g0{0}0N-s(s
" Show filename, language and col/row in statusline
set statusline=%f\ %h%m%r%y%=%c,%l/%L\ %P
set lazyredraw
" Disable color column.
set colorcolumn=0

let g:loaded_sql_completion = 1
let g:omni_sql_no_default_maps = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
" }}}
" {{{ VIM Mappings

" Shortcut for command-mode
nnoremap ; :

" Rename the name of the currently open file.
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')

    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" <leader>n to rename the name of the current file.
map <silent> <leader>n :call RenameFile()<cr>

" Clear search highlights by pressing escape twice.
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Moving between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
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

" {{{ CoC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
" {{{ ClangFormat

" Mappings
noremap <leader>F :pyf /usr/share/clang/clang-format.py<CR>

" }}}
" {{{ CtrlP

" Settings
let g:ctrlp_custom_ignore = 'node_modules$\|build$\|tmp$'

" Mappings
nnoremap <C-u> :CtrlPMixed<CR>

" }}}
" {{{ Markdown Preview
" Automatically open a browser window when entering a markdown buffer.
let g:mkdp_auto_start = 0
" Automatically close the browser window when exiting a mrkdown buffer.
let g:mkdp_auto_close = 1
" }}}
" {{{ Ansible
let g:ansible_unindent_after_newline = 1
" }}}

" {{{ netrw Configuration
function ToggleExplorer()
  if &ft == "netrw"
    if exists("w:netrw_rexlocal")
      Rexplore
    endif
  else
    Explore
  endif
endfun

let g:netrw_banner = 0 " Don't show the banner.
let g:netrw_browse_split = 0 " Open in the current window.
let g:netrw_list_hide=netrw_gitignore#Hide() .. ',^\./$' " Hide the current dot dir.
let g:netrw_liststyle = 3 " Use tree-style listing.
let g:netrw_sizestyle='H' " Display human-readable file sizes.

nnoremap <silent> <C-e> :call ToggleExplorer()<CR>
" }}}

" Automatically format the code according to the Rust guidelines when a buffer
" if saved and rust.vim is loaded
let g:rustfmt_autosave = 1

let g:tmpl_author_name = 'Mikkel Kroman'
let g:tmpl_author_email = 'mk@maero.dk'
let g:tmpl_search_paths = ['~/.config/nvim/templates']

" Print the name of the syntax elements under the cursor.
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

augroup autocmds
  autocmd!
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0#
  autocmd FileType rust setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
  autocmd FileType rust nnoremap <silent> <buffer> gb :CocCommand rust-analyzer.openDocs<CR>
  autocmd FileType c setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
  autocmd FileType python setlocal tabstop=4 softtabstop=0 shiftwidth=4 expandtab
  autocmd FileType markdown setlocal nowrap
  autocmd BufNewFile,BufRead *.plt setf gnuplot
  autocmd FileType Jenkinsfile setlocal shiftwidth=4 tabstop=4 textwidth&
  " Align GitHub-flavored Markdown tables
  autocmd FileType markdown,rust vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
  autocmd FileType yaml.ansible setlocal indentkeys-=\- indentkeys-=0# indentkeys-=<:>
augroup END

