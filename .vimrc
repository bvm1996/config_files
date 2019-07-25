
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" ========================================================
" ========================================================
" MY SETTINGS
" ========================================================
" ========================================================
"
" relative numeration and cross around cursor
set number
set relativenumber
set cursorline
set cursorcolumn

" match highlight color
hi Search ctermbg=Red

" cursor line color
highlight CursorColumn ctermbg=Green
highlight CursorLine ctermbg=Blue

" right border
set colorcolumn=80
hi ColorColumn ctermbg=Red

" mapping for navigation  between panes
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" macros for import sorting
nnoremap <leader>ss :set lazyredraw<CR>vip:sort u<CR>:'<,'>sort i<CR>:set nolazyredraw<CR>
" macros for pdb insert
nnoremap <leader>pdb :set lazyredraw<CR> oimport pdb; pdb.set_trace()<CR>pass<ESC>:set nolazyredraw<CR>

" macros for bad whitespace erase
nnoremap <leader>ee :EraseBadWhitespace<CR>
" insert \n
nnoremap <leader>nn i<CR><ESC>
" insert \n at the beginnig of a line
nnoremap <leader>NN I<CR><ESC>

" place swap-files to some directory
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" ctags
set tags=tags

" clean reqisters with :WipeReg
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" delete into nothingness
" map <leader>D "_d
" map <leader>DD "_dd

" enable plugins
call pathogen#helptags()
execute pathogen#infect()

" Enable folding
set foldmethod=indent
set foldlevel=99

" folding with tab + space
nnoremap <Tab><space> za

" show docs for folded stuff
let g:SimpylFold_docstring_preview=1

" PEP 8 identation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ | set softtabstop=4
    \ | set shiftwidth=4
    \ | set textwidth=79
    \ | set expandtab
    \ | set autoindent
    \ | set fileformat=unix

" frontend identation
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ | set softtabstop=2
    \ | set shiftwidth=2

" plugin bad-whitespace :EraseBadWhitespace

" airline status bar settings
set laststatus=2
let g:airline_theme='sierra'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


" NerdTree настройки
" показать NERDTree на F3
noremap <F3> :NERDTreeToggle<CR>
"игноррируемые файлы с расширениями
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

" TagBar настройки
" F4 для структуры файла
noremap <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1 " автофокус на Tagbar при открытии

" vim surround:
" cs'" - change ' to "
" ds - delete surround
" ysiw<symbol> - add surround: { - with spaces, } - without spaces

" указываем каталог с настройками SnipMate
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" TaskList настройки
noremap <F2> :TaskList<CR>

" Работа буфферами
noremap <C-q> :bd<CR>

" при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
"(does not work, but do I really need it? That is a question)
" augroup vimrc_autocmds
"     autocmd!
"     autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
"     autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
"     autocmd FileType ruby,python,javascript,c,cpp set nowrap
" augroup END

" not sure if it is even needed
if has("gui_running")
" GUI? устаналиваем тему и размер окна
  set lines=50 columns=125
  colorscheme elflord
endif

" настройка на Tab
"  (not sure what it is)
"  set smarttab
"  set tabstop=8

" python-mode hotkeys:
" \b - breakpoint (also snippet pdb)

let g:pymode_run_bind = '<leader>R'

" \R  - run code (changed to form \r to \R because of conflict with jedi
" rename)
"[[ - move from class to class
"[M - move from function to function
"
"add pylint to default code checkers
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
"jedi hotkeys:
"\g - go up in chain of definitions
"\d - go to definition
"K - docs
"\n - usages of variable
"\r - rename

" delete with <c-u> and <c-w> in insert mode made undoable
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" vim flagship, whatever it does
set laststatus=2
set showtabline=2
set guioptions-=e

" run command in another tmux pane
nnoremap <Leader>vp :VimuxPromptCommand<CR>

" git diff changes in runtime
let g:signify_realtime = 1

" jump to next git change
nnoremap <leader>gj <plug>(signify-next-hunk)
" jump to previous git change
nnoremap <leader>gk <plug>(signify-prev-hunk)

" disable auto deletion of spaces
let g:pymode_trim_whitespaces = 0

" hotkey for enabling pymode lint
nnoremap <leader>lnt :let g:pymode_lint=1<CR>
" hotkey for disabling pymode lint
nnoremap <leader>nolnt :let g:pymode_lint=0<CR>

" black left column with pretty colored marks
hi SignColumn ctermbg=none
hi SignifySignAdd cterm=bold ctermbg=none ctermfg=Green
hi SignifySignDelete cterm=bold ctermbg=none  ctermfg=Red
hi SignifySignChange cterm=bold ctermbg=none  ctermfg=Blue

" disable lint by default
let g:pymode_lint = 0

" splits function arguments into multiple lines
function! DefsplitFun()
	let line = getline('.')
	let line = join(split(line, "(")[1:-1], "(")
	let lines = split(line, ")")
	let line = join(lines[0:len(lines) - 2], ")")
	let lines = split(line, ', ')
	execute "normal! ^f(ci(\<enter>\<tab>".join(lines, ",\<enter>\<tab>").",\<enter>\<esc>"
endfunction

command! Defsplit call DefsplitFun()

" open new tab
nnoremap <silent> <leader>tt :$tabnew<CR>

" numbered tabs
" (does not work because of another plugin)
" (hmm, it works but looks kinda ugly, so I disabled it, by deleting
" taboo.vim) (though tab number is probably useful thing)
" let g:taboo_tab_format = " tab:%N%m "

" hotkeys for choosing tab by number
" (which is not actually displayed anywhere right now)
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

augroup html_indentation
	autocmd!
	autocmd Filetype html setlocal ts=4 sw=4 sts=0 expandtab
augroup END

" translation
vnoremap <leader>T <Plug>Translate
vnoremap <leader>R <Plug>TranslateReplace
vnoremap <leader>P <Plug>TranslateSpeak

let g:translate_cmd="trans :ru"

" Mimic Emacs Line Editing in Insert Mode Only
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
" â is <Alt-B>
inoremap â <C-Left>
" æ is <Alt-F>
inoremap æ <C-Right>
inoremap <C-K> <Esc>lDa
inoremap <C-U> <Esc>d0xi
inoremap <C-Y> <Esc>Pa
inoremap <C-X><C-S> <Esc>:w<CR>a
inoremap <M-f> <Esc>lwi

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" map common operator movements
" delete in parantheses
onoremap p i(
" delete in next parantheses
onoremap in( :<c-u>normal! f(vi(<cr>
" delete in last parantheses
onoremap il( :<c-u>normal! F)vi(<cr>
