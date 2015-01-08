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

" bring in lightline settings
so $VIMHOME/bundle/sourceables/lightline-config.vim

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

" Unite.vim Settings
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 0
let g:unite_enable_smart_case = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 15
let g:unite_update_time = 200

" CtrlP-like search using Unite.vim
if executable('ag')
	if has("win16") || has("win32") || has("win64")
	    "don't use async on Windows... for now. todo : fix the vimproc DLL
	    "issues and enable async on Windows too
		nnoremap <silent> <C-p> :<C-u>Unite -start-insert -buffer-name=files -start-insert buffer file_rec<CR>
    else
		let g:unite_source_rec_async_command= 'ag -p ~/.agignore --follow --nocolor --nogroup --hidden -g ""'
		let g:unite_source_grep_command = 'ag'
		let g:unite_source_grep_default_opts = '-i -p ~/.agignore --nogroup --nocolor --hidden'
		let g:unite_source_grep_recursive_opt = ''
		nnoremap <silent> <C-p> :<C-u>Unite -start-insert -buffer-name=files -start-insert buffer file_rec/async:!<CR>
	endif
else
    " fallback mode if no SilverSearcher (assuming no ag == no async either)
    nnoremap <silent> <C-p> :<C-u>Unite -start-insert -buffer-name=files -start-insert buffer file_rec<CR>
endif

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
\ 'ignore_pattern', join([
\ '.class$', '\.jar$',
\ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
\ '\.o$', '\.so$', '\.lo$', '\.lib$', '\.out$', '\.obj$', 
\ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$',
\ '\.ac$', '\.cache$', '\.0$' 
\ ], '\|'))

" misc unite settings
nnoremap <silent> <Leader>m :Unite -start-insert -buffer-name=recent file_mru<CR>
nnoremap <silent> <Leader>b :Unite -buffer-name=buffers buffer<CR>
nnoremap <silent> <Leader>y :Unite -buffer-name=yank history/yank<cr>
nnoremap <silent> <Leader>g :Unite grep:. -start-insert -buffer-name=search-buffer<CR>
nnoremap <silent> <Leader>r :UniteResume search-buffer<CR>
nnoremap <silent> <F11> :Unite -start-insert -buffer-name=tag-buffer tag<CR>

" Unite-tag settings
nnoremap <silent> <buffer> <Leader>z :UniteWithCursorWord -immediately tag<CR> 
nnoremap <silent> <Leader>o :Unite outline -vertical -winwidth=30 -buffer-name=outline-buffer<CR>

" Unite-session settings (autosave and reload on vim-launch)
let g:unite_source_session_enable_auto_save = 1 
" autocmd VimEnter * UniteSessionLoad 
nnoremap <silent> <Leader>l :<C-u>UniteSessionLoad<CR>

" Close unite windows with double tap <ESC>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

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

" play nice with  unite-quickfix source (pops up unite when hitting ma)
call unite#custom#profile('source/quickfix,source/location_list', 'context', {
\   'winheight': 13,
\   'direction': 'botright',
\   'start_insert': 1,
\   'keep_focus': 1,
\   'no_quit': 1,
\ })

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
