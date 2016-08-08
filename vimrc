set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
Plugin 'altercation/vim-colors-solarized'
Plugin 'darfink/vim-plist' " edit plist files in vim
Plugin 'rhysd/vim-clang-format' "use clang-format in vim
Plugin 'bkad/CamelCaseMotion' " move using camel case
Plugin 'scrooloose/nerdcommenter' " comment using <leader> ci
Plugin 'tmux-plugins/vim-tmux' " for tmux conf file
Plugin 'Valloric/YouCompleteMe' " for code completion
Plugin 'scrooloose/nerdtree' " for directory navigation
Plugin 'jistr/vim-nerdtree-tabs' " for using nerdtree with tabs in vim
Plugin 'Xuyuanp/nerdtree-git-plugin' " show git status in nerdtree

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


" ---------------------------------------------
" --------------- KEY MAPPINGS ----------------
" ---------------------------------------------

" set leader to ,
let mapleader = ","

" map ;a to ESC
inoremap ;a <Esc>
inoremap ;A <Esc>
inoremap jk <Esc>

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
map .. <leader>c<SPACE>


" NERDTree stuff
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" write as sudo
cnoremap w!! w !sudo tee % >/dev/null


" ---------------------------------------------
" --------------- LATEX SUITE -----------------
" --------------------------------------------- 

" change grep to generate file name for Latex-Suite
set grepprg=grep\ -nH\ $*

" set filetype of empty.tex files to 'tex' instead of 'plaintex'
let g:tex_flavor='latex'

" compile with pdflatex by default
let g:Tex_DefaultTargetFormat='pdf'

