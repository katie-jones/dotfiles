set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ

syntax enable
set background=light
colorscheme solarized
set vb

set spell spelllang=en_us

" Toggle between light/dark color schemes
call togglebg#map("<F5>")

" YouCompleteMe shit
let g:EclimCompletionMethod = 'omnifunc'

" line numbering
set number

" word wrap
set wrap
set linebreak
set nolist

" more natural window splitting
set splitbelow
set splitright

" // comments
let g:NERDCustomDelimiters = {'c': { 'leftAlt': '/*', 'rightAlt': '*/', 'left': '//'}}

" spaces before comments
let g:NERDSpaceDelims=1

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

" disable YCM for tex files
let g:ycm_filetype_blacklist = { 'tex' : 1 }


" ---------------------------------------------
" --------------- KEY MAPPINGS ----------------
" ---------------------------------------------

" set leader to ,
let mapleader = ","

" map ;a to ESC
inoremap ;a <Esc>
inoremap ;A <Esc>
inoremap jk <Esc>

" map jk to ESC
inoremap jk <ESC>

" navigate windows with alt-arrow
nnoremap f <C-w><C-L>
nnoremap b <C-w><C-H>
nnoremap  <C-w><C-J>
nnoremap  <C-w><C-K>

" navigate windows with ctrl-j/k/h/l
nnoremap <C-j> <C-w><C-j>
nnoremap <C-n> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" open file under cursor in new tab
nnoremap gF <C-w>gf
vnoremap gF <C-w>gf

" remap NERD Commenter toggle command
" map .. <plug>NERDCommenterToggle
map .. <Leader>c<space>


" NERDTree stuff
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" write as sudo
cnoremap w!! w !sudo tee % >/dev/null

" Delete trailing whitespace
command DeleteWhitespace %s/\s\+$//g


" ---------------------------------------------
" --------------- LATEX SUITE -----------------
" --------------------------------------------- 

" change grep to generate file name for Latex-Suite
set grepprg=grep\ -nH\ $*

" set filetype of empty.tex files to 'tex' instead of 'plaintex'
let g:tex_flavor='latex'

" compile with pdflatex by default
let g:Tex_DefaultTargetFormat='pdf'

