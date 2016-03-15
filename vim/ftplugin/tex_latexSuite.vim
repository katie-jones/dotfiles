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

