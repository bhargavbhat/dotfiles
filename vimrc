" disable vi compatibility
set nocompatible

" voodoo for runtimepath & $HOME location on Windows
if has("win16") || has("win32") || has("win64")
	let $VIMHOME = $HOME."/vimfiles"
	
	"runtimepath hacks for on windows
	let g:my_vim_dir=expand("$HOME/.vim")
	execute "set rtp^=".g:my_vim_dir
	execute "set rtp+=".g:my_vim_dir."\\after"
	let &rtp=substitute(&rtp,"[/]","\\","g")

	"if called from cygwin change shell to cmd.exe 
	if &shell=~#'bash$'
		set shell=$COMSPEC " sets shell to correct path for cmd.exe
	endif
else
	let $VIMHOME = $HOME."/.vim"
endif

" Pathogen Init
" list of disabled plugins
" let g:pathogen_disabled = ['EasyMotion'] 
call pathogen#infect()
call pathogen#helptags()

" general vim settings & options
syntax on
filetype plugin indent on
set ttimeoutlen=100
set ttyfast
set showmode						    " display current mode
set wildmode=longest,full			    " autocomplete for filenames 
set wildmenu							" enable wildmenu (with mode set above)
set hidden								" hide buffers instead of closing them
set laststatus=2						" display status line with filepath
set nowrap							    " don't wrap lines
set backspace=indent,eol,start          " backspace over everything in insert mode
set number							    " always show line numbers
set ignorecase						    " ignore case when searching
set smartcase    						" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab      						" insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=4     						" a tab is four spaces
set shiftwidth=4  						" number of spaces to use for autoindenting
set softtabstop=4   					" Sets the number of columns for a TAB to 4
set shiftround    						" use multiple of shiftwidth when indenting with '<' and '>'
set expandtab	  					    " replace tabs with spaces
set autoindent    						" always set autoindenting on
set cindent	  						    " stricter indenting for C family
set smartindent   						" smart indenting mode (auto indent for new lines)
set copyindent   						" copy the previous indentation on autoindenting
set hlsearch      						" highlight search terms
set incsearch     						" show search matches as you type
set nobackup	  						" disable backup file
set noswapfile	  					    " disable swap (*.swp) file
set smartcase	  						" enable smart-case searching (lowercase matches both)
set history=1000         				" remember more commands and search history
set undolevels=1000      				" use many muchos levels of undo
set title                				" change the terminal's title
set visualbell           				" don't beep
set noerrorbells         				" more don't beep
set splitbelow			 				" natural window splitting
set splitright			 				" natural window splitting
set autoread			 				" reload file changes
set noshowmode           				" hide the status line for I've got lightline

" common key mappings
let mapleader=","								" set leader key to ,
set pastetoggle=<F2>							" toggle for paste-mode
nmap <silent> <leader>/ :nohlsearch<CR>			" clear search term highlighting
nnoremap <leader><leader> <c-^>					" quickly switch between current & prev buffer
nnoremap <leader><leader>:ls<CR>:b<Space>		" show list of open buffers and prepare to switch

" Window naviation remap
nnoremap <C-S-J> <C-W><C-J>
nnoremap <C-S-K> <C-W><C-K>
nnoremap <C-S-L> <C-W><C-L>
nnoremap <C-S-H> <C-W><C-H>

" HiCursorWords Settings
let g:HiCursorWords_delay = 250

" gvim Stuff
if has('gui_running')
    if has("win16") || has('win32') || has ('win64')
        set guifont=Source\ Code\ Pro\ Medium:h13
    else
        set guifont=Source\ Code\ Pro\ Medium\ 13
    endif
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

" color scheme stuff
set t_Co=256
colorscheme apprentice
