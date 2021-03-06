" LaTeX filetype
"	  Language: LaTeX (ft=tex)
"	Maintainer: Srinath Avadhanula
"		 Email: srinath@fastmail.fm

" leave é unmapped
imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine


if !exists('s:initLatexSuite')
	let s:initLatexSuite = 1
	exec 'so '.fnameescape(expand('<sfile>:p:h').'/latex-suite/main.vim')

	silent! do LatexSuite User LatexSuiteInitPost
endif

silent! do LatexSuite User LatexSuiteFileType

" do just a bit of indentation
set sw=2
set tabstop=2
set shiftwidth=2
set expandtab

" use <C-n> to scroll through labels with \ref{
set iskeyword+=:


" compile with pdflatex by default
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_CompileRule_pdf = 'latexmk --interaction=nonstopmode $*'

" use <leader>lx to compile with xelatex
function! CompileXeTex()
  let oldCompileRule=g:Tex_CompileRule_pdf
  let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'
  call Tex_RunLaTeX()
  let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
map <Leader>lx :<C-U>call CompileXeTex()<CR>


" ------------- CUSTOM MACROS -----------------
" figure
let g:Tex_Env_figure = "\\begin{figure}[<++>]\<CR>\\centering\<CR>\\includegraphics[<++>]{<++>}\<CR>\\caption{<++>}\<CR>\\label{<++>}\<CR>\\end{figure}\<CR><++>"

" subfigure
call IMAP('ESF',"\\begin{subfigure}{<+subfigure width+>}\<CR>\\includegraphics[<+image size+>]{<+image file+>}\<CR>\\caption{<+caption+>}<++>\<CR>\\end{subfigure}\<CR><++>",'tex')


" Maps for mathbf
call IMAP('EBF',"\\mathbf{<++>}<++>",'tex') " insert mode
xnoremap <leader>b <Esc>`>a}<Esc>`<i\mathbf{<Esc>
nnoremap <leader>b ciw\mathbf{<C-r>"}<Esc>

" maps for vec
vnoremap <leader>v di\vc{<C-r>"}<Esc>
nnoremap <leader>v ciw\vc{<C-r>"}<Esc>
" vnoremap <leader>v di\bm{<C-r>"}<Esc>
" nnoremap <leader>v ciw\bm{<C-r>"}<Esc>

" maps for text
vnoremap <leader>t di\text{<C-r>"}<Esc>
nnoremap <leader>t ciw\text{<C-r>"}<Esc>

" maps for gls
call IMAP(',gg', '\gls{<++>}<++>', 'tex')
vnoremap <leader>g di\g{<C-r>"}<Esc>
nnoremap <leader>g ciw\g{<C-r>"}<Esc>


" map \omega
call IMAP('`w', '\omega', 'tex')

" map FR to fix indentation
nnoremap FR gg=G

" map ff to compile
nnoremap ff :w<CR>:!latexmk -pdf<CR><CR>
