" ---------------------------------------------
" ------------------ VUNDLE -------------------
" ---------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized' " color scheme
Plugin 'darfink/vim-plist' " edit plist files in vim
Plugin 'rhysd/vim-clang-format' "use clang-format in vim
Plugin 'bkad/CamelCaseMotion' " move using camel case
Plugin 'scrooloose/nerdcommenter' " kbd shortcuts for commenting
Plugin 'tmux-plugins/vim-tmux' " for tmux conf file
Plugin 'Valloric/YouCompleteMe' " for code completion
Plugin 'scrooloose/nerdtree' " for directory navigation
Plugin 'jistr/vim-nerdtree-tabs' " for using nerdtree with tabs in vim
Plugin 'Xuyuanp/nerdtree-git-plugin' " show git status in nerdtree
Plugin 'scrooloose/syntastic' " syntax highlighting
Plugin 'nvie/vim-flake8' " PEP 8 syntax highlighting
Plugin 'tmhedberg/SimpylFold' " python code folding
Plugin 'vim-scripts/indentpython.vim' " python indentation
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " status bar
Plugin 'aperezdc/vim-template' " template files

call vundle#end()
filetype plugin indent on

" ---------------------------------------------
" ---------------- BASIC SETUP ----------------
" ---------------------------------------------

syntax enable
set background=light
colorscheme solarized
set vb
set spell spelllang=en_us

" Toggle between light/dark color schemes
call togglebg#map("<F5>")

" line numbering
set number

" word wrap
set wrap
set linebreak
set nolist

" more natural window splitting
set splitbelow
set splitright

" set leader to ,
let mapleader = ","

" highlight long lines
highlight ColorColumn ctermbg=blue guibg=blue
call matchadd('ColorColumn', '\%80v', 100)

" ---------------------------------------------
" ----------------- NERD SHIT -----------------
" ---------------------------------------------

" // comments
let g:NERDCustomDelimiters = {'c': { 'leftAlt': '/*', 'rightAlt': '*/', 'left':
			\ '//'}}

" spaces before comments
let g:NERDSpaceDelims=1

" remap NERD Commenter toggle command
map <Leader>, <plug>NERDCommenterToggle

" NERDTree stuff
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" ---------------------------------------------
" ----------------- YCM SHIT ------------------
" ---------------------------------------------

" Eclim config
let g:EclimCompletionMethod = 'omnifunc'

" close preview window
let g:ycm_autoclose_preview_window_after_completion=1

" shortcut to go to item definition
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" disable YCM for tex files
let g:ycm_filetype_blacklist = { 'tex' : 1 }

" ---------------------------------------------
" --------------- TEMPLATE SHIT ---------------
" ---------------------------------------------

" Global templates directory
let g:templates_directory = '/home/katie/.vim/templates'

" Template filename prefix
let g:templates_global_name_prefix = 'template'

" No default templates
let g:template_no_builtin_template = 1

" Default username
let g:username = 'Katie Jones'

" ---------------------------------------------
" ---------------- FILE TYPES -----------------
" ---------------------------------------------

" set latex cls files to tex
au BufNewFile,BufRead *.cls set filetype=tex

" vraperrc files to vim
au BufNewFile,BufRead vrapperrc set filetype=vim
au BufNewFile,BufRead .vrapperrc set filetype=vim

" cc files to cpp
au BufNewFile,BufRead *.cc set filetype=cpp

" bash_katie to sh
au BufNewFile,BufRead .bash_katie set filetype=sh


" ---------------------------------------------
" --------------- KEY MAPPINGS ----------------
" ---------------------------------------------

" map join lines to M
nnoremap M J

" map ;a to ESC
inoremap ;a <ESC>
inoremap ;A <Esc>

" map jk to ESC
inoremap jk <ESC>
inoremap JK <ESC>

" navigate windows with JKLH
nnoremap J <C-w><C-j>
nnoremap K <C-w><C-k>
nnoremap L <C-w><C-l>
nnoremap H <C-w><C-h>

" open file under cursor in new tab
nnoremap gF <C-w>gf
vnoremap gF <C-w>gf

" write as sudo
cnoremap w!! w !sudo tee % >/dev/null

" Delete trailing whitespace
command DeleteWhitespace %s/\s\+$//g
nnoremap <Leader>dw :DeleteWhitespace<CR>

" insert a new line without entering insert mode
nnoremap <S-CR> O<Esc>j
nnoremap <CR> o<Esc>k

" code folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf


" ---------------------------------------------
" --------------- LATEX SUITE -----------------
" ---------------------------------------------

" change grep to generate file name for Latex-Suite
set grepprg=grep\ -nH\ $*

" set filetype of empty.tex files to 'tex' instead of 'plaintex'
let g:tex_flavor='latex'

" compile with pdflatex by default
let g:Tex_DefaultTargetFormat='pdf'

