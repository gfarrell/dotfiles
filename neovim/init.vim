" ---------------------------------------------------------
" Plugins (should be first as plug.vim executes some stuff)
" ---------------------------------------------------------

call plug#begin()

" Themes &c.
Plug 'morhetz/gruvbox'         " Gruvbox theme
Plug 'vim-airline/vim-airline' " Lightweight status bar

" General Plugins
Plug 'airblade/vim-gitgutter'                   " Show git line status in the gutter
Plug 'editorconfig/editorconfig-vim'            " Enable editorconfig
Plug 'frazrepo/vim-rainbow'                     " Use colours to match parens
Plug 'junegunn/fzf'                             " Fuzzy finding via FZF
Plug 'junegunn/fzf.vim'                         " Actual FZF vim plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'neomake/neomake'                          " Asynchronous script runner
Plug 'scrooloose/nerdtree'                      " File tree view
Plug 'terryma/vim-multiple-cursors'             " Multi-cursor support
Plug 'tpope/vim-commentary'                     " Makes commenting things out easier
Plug 'tpope/vim-fugitive'                       " Git utilities
Plug 'tpope/vim-surround'                       " change+add surrounding objects
Plug 'w0rp/ale'                                 " Async linting
Plug 'wellle/targets.vim'                       " Useful target objects

" Syntax plugins
Plug 'HerringtonDarkholme/yats.vim' " Syntax: typescript
Plug 'rust-lang/rust.vim'           " Syntax: rust
Plug 'chrisbra/csv.vim'             " Syntax: csv
Plug 'guns/vim-sexp'                " LISP expression manipulations
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Make sexp easier

" Tmux compatibility
Plug 'christoomey/vim-tmux-navigator'     " Navigation for vim / tmux splits
Plug 'tmux-plugins/vim-tmux-focus-events' " Make vim listen to tmux focus events

call plug#end()

" ---------------------------------------------------------
" General Options
" ---------------------------------------------------------

set mouse=a             " Enable mouse support
set fileencoding=utf-8  " Use utf-8 when writing to files
syntax on               " Allow syntax highlighting (nb `on` not `enable`)
set cursorline          " Highlight the current line
set number              " Show line numbers
set relativenumber      " Make line numbers relative to current line
set autoread            " Re-read files from disc when focussed
let mapleader=','       " Use , as the leader

" I find below, right more natural for new splits than top, left
set splitbelow
set splitright

" Use space for folding not za
nnoremap <Space> za

" ---------------------------------------------------------
" Aesthetics
" ---------------------------------------------------------

" Set the theme we're using
colorscheme gruvbox

" Enable 24b colours
set termguicolors

" Enable ALE support for Airline
let g:airline#extensions#ale#enabled=1

" ---------------------------------------------------------
" Handling files
" ---------------------------------------------------------

set textwidth=80       " Default wrap width
set fo=cqnj            " Formatting with comments, gq, and numbered lists
set formatprg=par\ r80 " Use par for formatting because it's nicer

set expandtab          " spaces not tabs
set shiftwidth=2       " 1 tab = 2 spaces
set softtabstop=2      " handle insertion of \t in insert mode
set autoindent         " keep indentation on new lines

" Deal with invisible characters
set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

" Don't use swapfiles or backups
set nobackup
set nowritebackup
set noswapfile

" Enable filetype detection
filetype on
filetype plugin on " load filetype plugins
filetype indent on " filetype-based indentation

" For makefiles don't expand tabs
autocmd BufEnter Makefile setlocal noexpandtab

" For markdown, also wrap text automatically
autocmd FileType markdown setlocal fo+=t

" ---------------------------------------------------------
" Plugin Settings
" ---------------------------------------------------------

" Plugin: ALE
" -----------

" I don't want the list to open automatically
let g:ale_open_list=0

" Add some shortcuts to finding next/prev issues (,ak ,aj)
nmap <leader>ak <Plug>(ale_previous_wrap)
nmap <leader>aj <Plug>(ale_next_wrap)

" ALE linters
let g:ale_linters = {
\ 'rust':       ['rls'],
\ 'python':     ['flake8'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'clojure':    ['clj-kondo'],
\}

" ALE fixers
let g:ale_fixers = {
\  '*':          ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\  'rust':       ['rustfmt'],
\}

" Rust linting config (use clippy)
let g:ale_rust_rls_config = {'rust': {'clippy_preference': 'on'}}

" Fix files on save
let g:ale_fix_on_save=1

" Plugin: COC (mostly stolen from the defaults -- must redo)
" ----------------------------------------------------------

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [
\ 'coc-emoji', 'coc-eslint', 'coc-prettier',
\ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
\ 'coc-css', 'coc-json', 'coc-rls', 'coc-yaml',
\ 'coc-texlab', 'coc-python'
\ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Misc plugin config
" ------------------

" Allow syntax highlighting for jsdocs
let g:javascript_plugin_jsdoc=1

" Open FZF 'Files' using Ctrl-P (replacing CtrlP)
nnoremap <C-P> :Files<CR>

" Run neomake automatically on buffer write
call neomake#configure#automake('w')

" Use rainbox parens for Rust, Typescript, Javascript, Clojure, Haskell
au FileType javascript,typescript,jsx,rust,haskell,clojure,zsh,bash,sh call rainbow#load()

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
