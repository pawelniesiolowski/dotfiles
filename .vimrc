"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" PlugInstall - Install plugins
" PlugUpdate - Install or update plugins
" PlugClean[!] - Remove unlisted plugins
" PlugUpgrade - Upgrade vim-plug itself

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'ronakg/quickr-preview.vim'
Plug 'tpope/vim-commentary'

Plug 'sheerun/vim-polyglot'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" enable highlighting for syntax
syntax on
" attempt to determine the type of a file based on its name and possibly its contents
filetype plugin indent on
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
" insert space characters whenever the tab key is pressed
set expandtab
" number of space characters that will be inserted when the tab key is pressed
set tabstop=4
" how many columns (=spaces) the cursor moves right when the <Tab> key is pressed
" and how many columns it moves left when <BS> (backspace) is pressed to erase a tab
set softtabstop=4
" the number of space characters inserted for indentation
set shiftwidth=4
" tab values for different files
autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype html.twig setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
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
" search command will move the highlight as characters to the search string are added
set incsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
" set the command window height to 1 line
set cmdheight=1
" jump to the first open window that contains the specified buffer (if there is one)
set switchbuf=useopen
" show minimal width of new vertical split
set winwidth=79
" prevent Vim from clobbering the scrollback buffer (see http://www.shallowsky.com/linux/noaltscreen.html)
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=10
" don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim/tmp//,.
set directory=~/.vim/tmp//,.
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" turn folding off
set foldmethod=manual
set nofoldenable
" insert only one space when joining lines that contain sentence-terminating punctuation like `.`
set nojoinspaces
" if a file is changed outside of vim, automatically reload it without asking
set autoread
" stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1
" diffs are shown side-by-side not above/below
set diffopt=vertical
" write swap files to disk and trigger CursorHold event faster (default is after 4000 ms of inactivity)
:set updatetime=400
" completion options (menu - use a popup menu, preview - show more info in menu)
:set completeopt=menu,preview
" instead of failing a command because of unsaved changes, raise a dialogue asking if you wish to save changed files
set confirm
" display line numbers on the left
set number
" set relative numbers
set rnu!
" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" color column after 120 chars
autocmd Filetype php highlight ColorColumn ctermbg=Red
autocmd Filetype php call matchadd('ColorColumn', '\%121v', 100)
" don't search in included files
setglobal complete-=i
" set leader key
nnoremap <Space> <Nop>
let mapleader="\<Space>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
nnoremap Y y$
" map <C-L> (redraw screen) to also turn off search highlighting
nnoremap <C-l> :nohl<CR>
" edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" switch between the last two files
nnoremap <Leader><Leader> <C-^>
" grep recursively by yanked fixed string
nnoremap <Leader>g :grep --recursive --fixed-strings '<C-r>"'<space>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.fzf
noremap <C-h> :History<CR>
noremap <C-n> :GFiles<CR> 
noremap <C-k> :Files<CR> 
noremap <C-j> :History:<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD TREE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>f<Tab> :NERDTreeFind<CR>
nnoremap <Leader><Tab> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QUICK FIX WINDOW
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>o :copen<CR>
nnoremap <Leader>c :cclose<CR>

let g:quickr_preview_position = 'above'
let g:quickr_preview_on_cursor = 1
let g:quickr_preview_exit_on_enter = 1
let g:quickr_preview_modifiable = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
	" clear all autocmds in the group
	autocmd!
	" jump to last cursor position unless it's invalid or in an event handler
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
augroup END

