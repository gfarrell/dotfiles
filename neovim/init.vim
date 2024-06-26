lua require("plugins")
lua require("general")

" lua require("theme")
colorscheme gruvbox
set termguicolors

lua require("editor")
lua require('lsp')
lua require('treesitter')
lua require("misc")

" ---------------------------------------------------------
" Useful functions (use with :call <name>)
" ---------------------------------------------------------

" Function: Export current markdown as PDF
" ----------------------------------------
function! ExportMarkdownToPdf(destination)
    call system("pandoc --from=markdown --latex-engine=xelatex -o " . shellescape(a:destination) . " " . shellescape(expand("%")))
endfunction

" Function: Join paragraph lines into single line
" -----------------------------------------------
function! JoinLinesInParagraphs()
    execute '%s/\(\S\)\n\(\S\)/\1 \2/'
endfunction

" Function (auto): create directories on write if necessary
" ---------------------------------------------------------
function! s:MkNonExDir(file, buf)
      if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
          if !isdirectory(dir)
            call mkdir(dir, 'p')
          endif
      endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Search with Ag into a quickfix list
" -----------------------------------
function! AgQF(term)
  cexpr system("ag " . shellescape(a:term))
  copen
endfunction
