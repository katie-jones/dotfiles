" Show docstring when folding code
let g:SimpylFold_docstring_preview=1

" mark bad whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
match BadWhitespace /\s\+$/

" use utf-8 encoding
set encoding=utf-8

" turn syntax highlighting on
let python_highlight_all=1
syntax on

" use unix line breaks etc
set fileformat=unix

" Camel Case
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge

" Disable auto line breaks
set textwidth=0
set wrapmargin=0
set formatoptions-=t

" Wrap long strings
if !exists('*ReformatMultiLines')
    function ReformatMultiLines()
      let brx = '^\s*"'
      let erx = '"\s*$'
      let fullrx = brx . '\(.\+\)' . erx
      let startLine = line(".")
      let endLine   = line(".")
      while getline(startLine) =~ fullrx
        let startLine -= 1
      endwhile
      if getline(endLine) =~ erx
        let endLine += 1
      endif
      while getline(endLine) =~ fullrx
        let endLine += 1
      endwhile
      if startLine != endLine
        exec endLine . ' s/' . brx . '//'
        exec startLine . ' s/' . erx . '//'
        exec startLine . ',' . endLine . ' s/' . fullrx . '/\1/'
        exec startLine . ',' . endLine . ' join'
      endif
      exec startLine
      let orig_tw = &tw
      if &tw == 0
        let &tw = &columns
        if &tw > 79
          let &tw = 79
        endif
      endif
      let &tw -= 3 " Adjust for missing quotes and space characters
      exec "normal A%-%\<Esc>gqq"
      let &tw = orig_tw
      let endLine = search("%-%$")
      exec endLine . ' s/%-%$//'
      if startLine == endLine
        return
      endif
      exec endLine
      exec 'normal I"'
      exec startLine
      exec 'normal A "'
      if endLine - startLine == 1
        return
      endif
      let startLine += 1
      while startLine != endLine
        exec startLine
        exec 'normal I"'
        exec 'normal A "'
        let startLine += 1
      endwhile
    endfunction
endif
