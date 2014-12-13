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

" NERDTree configuration
nmap <Leader>t :NERDTreeToggle<CR>                  " show/hide NERDTree pane
map <Leader>n :NERDTreeFind<CR>                     " reveal the current file in NERDTree
let g:nerdtree_tabs_no_startup_for_diff     = 0     " disable for diff mode
let g:nerdtree_tabs_smart_startup_focus     = 2     " set focus to file window on startup
let g:nerdtree_tabs_synchronize_view        = 1     " sync cursor position in all views
let g:nerdtree_tabs_focus_on_files          = 1     " focus files on tabswitch
let g:nerdtree_tabs_open_on_console_startup = 0     " nerdtree on startup state

" NeoComplete settings
let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#force_overwrite_completefunc      = 1
let g:neocomplete#auto_completion_start_length      = 2
let g:neocomplete#manual_completion_start_length    = 2
let g:neocomplete#min_keyword_length                = 3
let g:neocomplete#enable_auto_close_preview         = 1
let g:neocomplete#enable_omni_fallback              = 0
let g:neocomplete#keyword_patterns                  = {}
let g:neocomplete#keyword_patterns._                = '\h\w*'
let g:neocomplete#sources#omni#input_patterns       = {}
let g:neocomplete#sources#omni#input_patterns.c     = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp   = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" NeoSnippets
let g:neosnippet#snippets_directory='$HOME/.vim/bundle/neosnippet-snippet'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Sneak settings
let g:sneak#use_ic_scs = 1
hi link SneakPluginTarget ErrorMsg
hi link SneakStreakTarget ErrorMsg
hi link SneakStreakMask Comment

nmap ; <Plug>SneakNext
nmap \ <Plug>SneakPrevious
nmap <Leader>s <Plug>(SneakStreak)
nmap <Leader>S <Plug>(SneakStreakBackward)

"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" vim-bookmarks
nmap <Leader>j  <Plug>BookmarkNext
nmap <Leader>k  <Plug>BookmarkPrev
let g:bookmark_sign = '~~'
let g:bookmark_annotation_sign = '##'
let g:bookmark_auto_save = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save_file = $VIMHOME .'/.saved-vim-bookmarks' 

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
