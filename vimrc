" ---------------------------------------------
" ------------------ VUNDLE -------------------
" ---------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

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
Plugin 'hdima/python-syntax' " python syntax highlighting
Plugin 'hynek/vim-python-pep8-indent' " python indentation

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
map .. <plug>NERDCommenterToggle

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
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" disable YCM for tex files
let g:ycm_filetype_blacklist = { 'tex' : 1 }


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

" set leader to ,
let mapleader = ","

" map ;a to ESC
inoremap ;a <Esc>
inoremap ;A <Esc>

" map jk to ESC
inoremap jk <ESC>
inoremap JK <ESC>

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

