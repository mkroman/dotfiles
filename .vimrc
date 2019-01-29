" Copyright (c) 2015, Mikkel Kroman <mk@maero.dk>
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
else
  " terminal overrides
  let g:jellybeans_overrides = {
  \  'background': { 'guibg': 'none', 'guifg': 'f9f9e8' },
  \}
endif
" }}}

if filereadable($HOME.'/.vundlerc')
  source ~/.vundlerc
endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')

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
if &t_Co > 2 || has('gui_running')
  " Disable the menu, scrollbar, etc.
  set guioptions-=m guioptions-=T guioptions-=e guioptions-=r guioptions-=L

  " Meslo is a customized version of Apple's Menlo font
  set guifont=Roboto\ Mono\ 9
  set guiheadroom=0

  syntax on

  try
    colorscheme jellybeans
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

" {{{ VIM Configuration

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

" Change the leader key
let mapleader = ","

" Turn off case sensivity and turn on smart case searching
set ignorecase smartcase

" Highlight search terms (even dynamically)
set hlsearch incsearch

" Shorten the “press ENTER to …” message
set shortmess=atI

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
set list listchars=tab:▸\ ,eol:¬

" Don't write swap-files or backup files
set noswapfile nobackup

" Key-map for pasting large amounts of text
set pastetoggle=<F2>

" Show the status line
set laststatus=2

" Enable folding using {{{ and }}}
set foldenable foldmethod=manual foldmarker={{{,}}}

" Print solid (unicode) lines for vertical splits
set fillchars+=vert:\ 

" Set a 80-character margin
set colorcolumn=0

" Non-obnoxious wrapping
set textwidth=80 formatoptions=cq wrapmargin=0

" Enable full mouse support
set mouse=a

" Use `par` for formatting
set formatprg=par\ -w80

" C/C++ code formatting
set cinoptions=g0{0}0N-s(0

set lazyredraw

let g:loaded_sql_completion = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" }}}

" {{{ VIM Mappings

" Shortcut for command-mode
nnoremap ; :

" Clear active highlighted search results
nmap <silent> <leader>/ :nohlsearch<CR>

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
nmap <S-j> 10j
nmap <S-k> 10k

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

" }}}
" {{{ Bundles
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
noremap <leader>f :pyf /usr/share/clang/clang-format.py<CR>
" inoremap <C-i> <c-o>:pyf /usr/share/clang/clang-format.py<CR>

" }}}
" {{{ CtrlP

" Settings
let g:ctrlp_custom_ignore = 'build$\|tmp$'

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
" {{{ VimFiler

" Settings

" Use VimFiler as the default explorer
let g:vimfiler_as_default_explorer = 1

" Change the folder characters
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

" Mappings
nnoremap <leader>e :VimFilerExplorer<CR>
nnoremap <C-e> :VimFilerExplorer<CR>

" }}}

" {{{ ALE
highlight ALEWarning ctermbg=black cterm=bold
" let g:ale_sign_warning = '-'
" }}}

" }}}
"
"

map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

