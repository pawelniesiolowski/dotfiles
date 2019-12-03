call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'lumiliet/vim-twig'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
" insert 4 space characters whenewer the tab key is pressed
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" when opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on
set autoindent
" always display the status line, even if only one window is displayed
set laststatus=2
" the cursor will briefly jump to the matchin brace when you insert one
set showmatch
set matchtime=3
" highlight searches
set hlsearch
set incsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" set the command window height to 2 lines
set cmdheight=2
" jump to the first open window that contains the specified buffer (if there is one)
set switchbuf=useopen
" Show minimal width of new vertical split
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" backups
set backup
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" enable highlighting for syntax
syntax on
" attempt to determine the type of a file based on its name and possibly its
" contents
filetype indent plugin on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1
" Diffs are shown side-by-side not above/below
set diffopt=vertical
" Write swap files to disk and trigger CursorHold event faster (default is
" after 4000 ms of inactivity)
:set updatetime=1000
" Completion options.
"   menu: use a popup menu
"   preview: show more info in menu
:set completeopt=menu,preview
" display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
" instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
" Enable use of the mouse for all modes
set mouse=a
" display line numbers on the left
set number
" set relative numbers
set rnu!
" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" use <F2> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F2>
" netrw - disable banner
let g:netrw_banner=0
" search recursive
set path+=**
" ignore some directories for find command
set wildignore+=**/vendor/**
set wildignore+=**/var/**
" set leader key
:let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
nnoremap Y y$
" map <C-L> (redraw screen) to also turn off search highlighting
nnoremap <C-L> :nohl<CR><C-L>
" edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Paste grep command with default options
nnoremap ,g :!grep -rwnI --color=always
" Grep for word and load found files to current buffers
command! -nargs=* Gr args `grep --recursive --word-regexp --files-with-matches -I <args>`
" move around splits with <c-hjkl>
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l
" close all other splits
nnoremap <leader>o :only<cr>
" FZF
set rtp+=~/.fzf
noremap <C-h> :History<CR>
noremap <C-n> :GFiles<CR> 
noremap <C-k> :Files<CR> 
noremap <C-j> :History:<CR>
" PHP namespaces with vim-php-namespaces mappings
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM TEMPLATES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,tnsk :-1read $HOME/.vim/vim_templates/.skeleton.work.php.nsk<CR>10j<S-a>
nnoremap ,ttestnsk :-1read $HOME/.vim/vim_templates/.skeleton.work.php.nsk.test<CR>12j<S-w>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
	" clear all autocmds in the group
	autocmd!
	" jump to last cursor position unless it's invalid or in an event handler
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufOnly.vim  -  delete all the buffers except the current/named buffer.
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Usage:
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer]
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction

noremap ,bo :BufOnly<cr>
