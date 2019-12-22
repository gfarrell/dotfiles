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
Plug '/usr/local/opt/fzf'                       " FZF installed via Homebrew
Plug 'junegunn/fzf.vim'                         " Fuzzy finding via FZF
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'neomake/neomake'                          " Asynchronous script runner
Plug 'scrooloose/nerdtree'                      " File tree view
Plug 'terryma/vim-multiple-cursors'             " Multi-cursor support
Plug 'tpope/vim-fugitive'                       " Git utilities
Plug 'tpope/vim-surround'                       " change+add surrounding objects
Plug 'w0rp/ale'                                 " Async linting

" Syntax plugins
Plug 'leafgarland/typescript-vim' " Syntax: typescript
Plug 'rust-lang/rust.vim'         " Syntax: rust

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

" Plugin: COC (mostly stolen from lucasfcosta -- must redo)
" ---------------------------------------------------------

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

" Use `lj` and `lk` for navigate diagnostics
nmap <silent> <leader>lj <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>lk <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Map <c-space> to trigger completion and cycle through it
inoremap <silent><expr> <c-space> coc#refresh()


" Misc plugin config
" ------------------

" Allow syntax highlighting for jsdocs
let g:javascript_plugin_jsdoc=1

" Open FZF 'Files' using Ctrl-P (replacing CtrlP)
nnoremap <C-P> :Files<CR>

" Run neomake automatically on buffer write
call neomake#configure#automake('w')

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
