" Exisiting in the Windows VIM install
set nocompatible
" Imported specific stuff from here instead...
" source $VIMRUNTIME/vimrc_example.vim 
" None of this Windows shit...
"source $VIMRUNTIME/mswin.vim
"behave mswin

" --------------------------------
" Imported from vimrc_example.vim
" --------------------------------
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" --------------------------------
" File Formats
" --------------------------------
au BufNewFile,BufRead *.as setf actionscript

" --------------------------------
" My custom commands
" --------------------------------
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab!

set nowrap
set autochdir

let g:netrw_list_hide='\(^\|\s\s\)\zs\.[^\.]\S\+'

" Insert lines without going into insert mode
nnoremap ,o o<ESC>
nnoremap ,O o<ESC>

" Load PHPDoc
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR>

" Activate maps for Git Rebase
nnoremap <buffer> <silent> S :Cycle<CR>
nnoremap <buffer> <silent> Sp :Pick<CR>
nnoremap <buffer> <silent> Sr :Reword<CR>
nnoremap <buffer> <silent> Se :Edit<CR>
nnoremap <buffer> <silent> Ss :Squash<CR>
nnoremap <buffer> <silent> Sf :Fixup<CR>
nnoremap <buffer> <silent> Sx :Exec<CR>
if !exists(":Rebase")
fu! Rebase()
    if !exists('b:in_rebase') || !b:in_rebase
		nnoremap <buffer> <silent> p :Pick<CR>
		nnoremap <buffer> <silent> r :Reword<CR>
		nnoremap <buffer> <silent> e :Edit<CR>
		nnoremap <buffer> <silent> s :Squash<CR>
		nnoremap <buffer> <silent> f :Fixup<CR>
		nnoremap <buffer> <silent> x :Exec<CR>
        let b:in_rebase = 1
    else 
        nunmap p
        nunmap r
        nunmap e
        nunmap s
        nunmap f:help 
        nunmap x
        let b:in_rebase = 0
    endif
endfunction
endif

colorscheme candycode
