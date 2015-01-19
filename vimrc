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
" let g:pathogen_disabled = ['vim-easytags','vim-misc'] 
call pathogen#infect()
call pathogen#helptags()

" general vim settings & options
syntax on                                                   " turn on syntax highlighting
filetype plugin indent on                                   " filetype based indentation
set ttimeoutlen=100
set ttyfast
set wildmode=longest,full                                   " autocomplete for filenames 
set wildmenu                                                " enable wildmenu (with mode set above)
set hidden                                                  " hide buffers instead of closing them
set laststatus=2                                            " display status line with filepath
set nowrap                                                  " don't wrap lines
set backspace=indent,eol,start                              " backspace over everything in insert mode
set number                                                  " always show line numbers
set ignorecase                                              " ignore case when searching
set smartcase                                               " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab                                                " insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=4                                               " a tab is four spaces
set shiftwidth=4                                            " number of spaces to use for autoindenting
set softtabstop=4                                           " Sets the number of columns for a TAB to 4
set shiftround                                              " use multiple of shiftwidth when indenting with '<' and '>', i.e when indenting at 3 spaces go to 4, not 5"
set expandtab                                               " replace tabs with spaces
set autoindent                                              " always set autoindenting on
set cindent                                                 " stricter indenting for C family
set smartindent                                             " smart indenting mode (auto indent for new lines)
set copyindent                                              " copy the previous indentation on autoindenting
set hlsearch                                                " highlight search terms
set incsearch                                               " show search matches as you type
set nobackup                                                " disable backup file
set noswapfile                                              " disable swap (*.swp) file
set smartcase                                               " enable smart-case searching (lowercase matches both)
set history=1000                                            " remember more commands and search history
set undolevels=1000                                         " use many muchos levels of undo
set title                                                   " change the terminal's title
set visualbell                                              " don't beep
set noerrorbells                                            " more don't beep
set splitbelow                                              " natural window splitting
set splitright                                              " natural window splitting
set autoread                                                " reload file changes
set nostartofline                                           " don't jump to first column
set shortmess=at                                            " shorter error messages
set spelllang=en                                            " set English as spell check lang
set nospell                                                 " turn spell check off
set iskeyword+=_                                            " treat _ as a part of a word
set noerrorbells                                            " don't make noise...
set novisualbell                                            " ... and don't blink either
set numberwidth=5                                           " line nums run upto 99999
set esckeys                                                 " allow arrow keys with ESC keycode
set noshowmode                                              " hide the status line, use lightline instead

" folding stuff
set nofoldenable                                            " Turn off auto-folding
set foldlevelstart=100                                      " ensure folds are open
set foldmethod=syntax                                       " Fold using syntax
set foldopen=block,hor,mark,percent,quickfix,tag            " define what movements open folds
set fillchars=fold:\                                        " padding char for folds, there's a trailing space after the \   
set foldnestmax=10                                          " max 10 levels of nesting
nnoremap <space> za                                         " Toggle folds with space key
        
" common key mappings       
let mapleader=","                                           " set leader key to comma
set pastetoggle=<F2>                                        " toggle for paste-mode
nnoremap <silent> <leader>/ :nohlsearch<CR>                 " clear search term highlighting
nnoremap <silent> <leader><leader> <c-^>                    " quickly switch between current & prev buffer
" show list of open buffers and prepare to switch
nnoremap <leader>b :ls<CR>:b<space>
inoremap jk <Esc>                                           " use jk to simulate ESC key
hi link cTodo SpellBad                                      " highlight TODO/FIXME similar to spelling mistakes

" visual mode remaps        
nmap gV `[v`]                                               " visual reselect last changed area
vnoremap <C-j> :m '>+1<CR>gv=gv                             " move visual block down 1 line
vnoremap <C-k> :m '<-2<CR>gv=gv                             " move visual block up 1 line

" spell-check stuff
map <F5> :setlocal spell!<CR>                               " F5 to toggle spell check on/off
inoremap <F5> <C-\><C-O>:setlocal spell! spell?<CR>         " (see above)
nnoremap zn ]s                                              " next misspelled word
nnoremap zp [s                                              " prev misspelled word

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
nmap <Leader>t :NERDTreeToggle<CR>                          " show/hide NERDTree pane
map <Leader>n :NERDTreeFind<CR>                             " reveal the current file in NERDTree
let g:nerdtree_tabs_no_startup_for_diff             = 0     " disable for diff mode
let g:nerdtree_tabs_smart_startup_focus             = 2     " set focus to file window on startup
let g:nerdtree_tabs_synchronize_view                = 1     " sync cursor position in all views
let g:nerdtree_tabs_focus_on_files                  = 1     " focus files on tabswitch
let g:nerdtree_tabs_open_on_console_startup         = 0     " nerdtree on startup state

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
if has('conceal')
        set conceallevel=2 concealcursor=vin
endif

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" NeoSnippet settings
let g:neosnippet#snippets_directory='$HOME/.vim/bundle/neosnippet-snippet'
"let g:neosnippet#snippets_directory='$HOME/.vim/bundle/vim-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" Unite Settings
let g:unite_source_history_yank_enable  = 1
let g:unite_enable_start_insert         = 0
let g:unite_enable_smart_case           = 1
let g:unite_split_rule                  = "botright"
let g:unite_force_overwrite_statusline  = 0
let g:unite_winheight                   = 15
let g:unite_update_time                 = 200
let g:unite_abbr_highlight              = 'Normal'

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
" bring in the ignore files list for unite
so $VIMHOME/bundle/sourceables/unite-ignore-files.vim

" Unite keymappings
nnoremap <silent> <Leader>m :Unite -buffer-name=unite-recent-file-mru -start-insert<CR>
nnoremap <silent> <Leader>b :Unite -buffer-name=unite-buffers buffer<CR>
nnoremap <silent> <Leader>y :Unite -buffer-name=unite-yank history/yank<CR>
nnoremap <silent> <Leader>g :Unite grep:. -buffer-name=unite-search-buffer -start-insert<CR>
nnoremap <silent> <Leader>r :UniteResume unite-search-buffer<CR>

" Close unite windows with double tap <ESC>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" Unite-tag settings
nnoremap <silent> <Leader>z :UniteWithCursorWord tag -profile-name=navigate<CR>
nnoremap <silent> <F12> :Unite -start-insert -buffer-name=unite-tag-buffer tag<CR>

" Unite-outline settings 
nnoremap <silent> <Leader>o :Unite outline -vertical -winwidth=30 -buffer-name=unite-outline-buffer<CR>

" Unite-session settings
let g:unite_source_session_enable_auto_save = 1
nnoremap <silent> <Leader>l :UniteSessionLoad<CR>

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

" indentLine settings
let g:indentLine_bufNameExclude         = ['_.*', 'NERD_tree.*', 'unite-.*']
let g:indentLine_leadingSpaceChar       = '·'
let g:indentLine_char                   = '|'
let g:indentLine_indentLevel            = 20
let g:indentLine_leadingSpaceEnabled    = 0

" vim-bookmarks settings
let g:bookmark_sign                 = '~~'
let g:bookmark_annotation_sign      = '##'
let g:bookmark_auto_save            = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save_file       = $VIMHOME .'/.saved-vim-bookmarks' 

" vim-bookmarks keymapping
nmap <Leader>j  <Plug>BookmarkNext
nmap <Leader>k  <Plug>BookmarkPrev

" make vim-bookmarks play nice with  unite-quickfix source
call unite#custom#profile('source/quickfix,source/location_list', 'context', {
\   'winheight': 13,
\   'direction': 'botright',
\   'start_insert': 1,
\   'keep_focus': 1,
\   'no_quit': 1,
\ })

" tags and cscope
set tags=./tags,tags;$VIMHOME/stl_tags

"turn of precise truncation
let g:unite_source_tag_strict_truncate_string = 0

"gtags stuff
set csprg=gtags-cscope
cscope add ./GTAGS,GTAGS
nnoremap <leader>gg :execute 'Unite gtags/def:'.expand('<cword>')<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>ge :execute 'Unite gtags/grep'<CR>

" find all references to symbol under cursor
" nmap <leader>r :scs find s <C-R>=expand("<cword>")<CR><CR>
" find all calls to function name under cursor - isn't very useful for CPP
" nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" find all called functions - isn't very useful for CPP
" nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

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
set background=dark
colorscheme apprentice
