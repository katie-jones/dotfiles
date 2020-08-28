" Set all files to c with subtype doxygen.
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" Doxygen setup.
let g:DoxygenToolkit_briefTag_pre="@brief      "
let g:DoxygenToolkit_briefTag_post="<++>"
let g:DoxygenToolkit_paramTag_pre="@param      [<++>] "
let g:DoxygenToolkit_paramTag_post=": <++>"
let g:DoxygenToolkit_returnTag="@return     <++>"

" No auto-format buffer
au BufReadPost * let b:codefmt_auto_format_buffer = 0

" Add command to run PC Lint
map <F7> :call LintProject()<cr>

function! LintProject()
    new
    exec 'set buftype=nofile'
    exec 'silent r! cd ../../../Lint; ./run_lint.sh'
    exec 'normal ggdj'
    exec 'g/Start of Pass/d'
endfunction

" Add command to open file under cursor in previous buffer
nnoremap gfb :call OpenFilePrevBuf()<cr>
vnoremap gfb :call OpenFilePrevBuf()<cr>

function! OpenFilePrevBuf()
    exec 'let mycurf=expand("<cfile>")'
    exec 'winc w'
    exec "e ".mycurf
    exec 'winc p'
endfunction
