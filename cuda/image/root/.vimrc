"--------------------------------------------------------------------------------
" basics
"--------------------------------------------------------------------------------
set nocompatible nomodeline showcmd showmode
"set lines=64 columns=120
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,gbk,gb18030,gb2312

set tabstop=4 " set tab width
set softtabstop=4
set textwidth=120      " set to 0 for 'wrapmargin' taking effect
set formatoptions+=mM
" set wrapmargin=120 " Define right margin for line wrapping
highlight rightMargin term=bold ctermbg=red ctermfg=white guibg=red
match rightMargin /.\%>81v*/
set backspace=2 " enable backspace
set number! " show line number
set whichwrap=b,s,<,>,[,] " jump between lines at eol & bol
set listchars=tab:.\ ,trail:. " show tab as: '. '
" set autochdir " change dir to editing file's automatically
" this could fail a cscope auto-generation.
set hidden " hide buffer automatically
set scrolloff=5

"if has("gui_running")
"  if has("gui_gtk2")
"    set guifont=Inconsolata\ 12
"  elseif has("gui_win32")
"    set guifont=Consolas:h12:cANSI
"  endif
"endif
colorscheme desert
" colorscheme morning

" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set nobackup
set nowritebackup
set noswapfile

" cursor shape
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" mouse scroll
set mouse=v


"--------------------------------------------------------------------------------
" search & replace
"--------------------------------------------------------------------------------
set hlsearch " highlight search results
set incsearch "
set ignorecase smartcase
set gdefault " replace all match within a line, so append 'g' will toggle it off

"--------------------------------------------------------------------------------
" status line
"--------------------------------------------------------------------------------
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2 " always show the status line
set ruler " bottom right about current position

"--------------------------------------------------------------------------------
" programming
"--------------------------------------------------------------------------------
set completeopt=longest,menu " only insert longest, show menu
set showmatch " show matched brackets
set smartindent "
set shiftwidth=4 "
set expandtab " expand <tab> to spaces
set autoindent "
set ai! " automatically indent
syntax enable
syntax on

"--------------------------------------------------------------------------------
" folding
"--------------------------------------------------------------------------------
"set foldmarker={,}
"set foldmethod=marker
set foldmethod=syntax
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
"set foldopen-=search " don't open folds when you search into them
"set foldopen-=undo " don't open folds when you undo stuff
"set foldcolumn=4

"--------------------------------------------------------------------------------
" some short-cuts
"--------------------------------------------------------------------------------
" copy
vnoremap <C-Insert> "+y
" cut
vnoremap <S-Del> "+x
" paste
set pastetoggle=<F8>
map <S-Insert>        "+gP
cmap <S-Insert>        <C-R>+

"--------------------------------------------------------------------------------
" QuickFix
"--------------------------------------------------------------------------------
nmap <F5> :tabedit %:h
nmap <F6> :tabn<cr> " show next tab
nmap <S-F6> :tabp<cr> " show prev tab

"--------------------------------------------------------------------------------
" tricks
"--------------------------------------------------------------------------------
" write to a file using sudo if you forgot to sudo vim file
" it will prompt for sudo password when writing
" %!, entire file through filter; then exec null cmd, gain sudo power; and
" also tee to entire file (%)
cmap W!!! %!sudo tee > /dev/null %

" open the file explorer, and hit another - to move up one directory
nmap _ :Vexplore!<CR>
nmap - :Explore!<CR>


"--------------------------------------------------------------------------------
" TagList
"--------------------------------------------------------------------------------
set tags=tags;/ " look in the current directory for tags
                " and work up the tree towards root until one is found
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
if has('win32')
    let Tlist_Ctags_Cmd = 'ctags.exe'
    map <C-F7> :let g:cwDirName=getcwd()<CR>:!ctags.exe -R --c++-kinds=+px --fields=+iaS --extra=+q .<CR>:exec 'set tags=' . g:cwDirName . '/tags'<CR>
elseif has('unix')
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    map <C-F7> :let g:cwDirName=getcwd()<CR>:!ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .<CR>:exec 'set tags=' . g:cwDirName . '/tags'<CR>:!cscope -Rbq<CR>:exec "cs add " . g:cwDirName . "/cscope.out " . g:cwDirName<CR>
endif


"--------------------------------------------------------------------------------
" Cscope
"--------------------------------------------------------------------------------
let g:cwDirName=getcwd()
:set cscopequickfix=s-,c-,d-,i-,t-,e- "show cscope result in quickfix window

if has("cscope")

""""""""""""" Standard cscope/vim boilerplate
" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=0

" show msg when any other cscope db added
set cscopeverbose

" set csprg=/usr/local/bin/cscope
"set nocsverb
" add any database in current directory
if filereadable("cscope.out")
silent exec "cs add " . g:cwDirName . "/cscope.out " . g:cwDirName
" else add database pointed to by environment
" note here '"' allow variable substitution
elseif $CSCOPE_DB != ""
silent exec "cs add $CSCOPE_DB " . g:cwDirName
endif
"set csverb

""""""""""""" My cscope/vim key mappings
"
" The following maps all invoke one of the following cscope search types:
"
" 's' symbol: find all references to the token under cursor
" 'g' global: find global definition(s) of the token under cursor
" 'c' calls: find all calls to the function name under cursor
" 't' text: find all instances of the text under cursor
" 'e' egrep: egrep search for the word under cursor
" 'f' file: open the filename under cursor
" 'i' includes: find files that include the filename under cursor
" 'd' called: find functions that function under cursor calls
"

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>lt;CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nmap <C-_>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :scs find i ^<C-R>=expand("<cfile>")<CR>lt;CR>
nmap <C-_>d :scs find d <C-R>=expand("<cword>")<CR><CR>

""""""""""""" key map timeouts
"
" By default Vim will only wait 1 second for each keystroke in a mapping.
" You may find that too short with the above typemaps. If so, you should
" either turn off mapping timeouts via 'notimeout'.
"
"set notimeout
"
" Or, you can keep timeouts, by uncommenting the timeoutlen line below,
" with your own personal favorite value (in milliseconds):
"
"set timeoutlen=4000
"
" Either way, since mapping timeout settings by default also set the
" timeouts for multicharacter 'keys codes' (like <F1>), you should also
" set ttimeout and ttimeoutlen: otherwise, you will experience strange
" delays as vim waits for a keystroke after you hit ESC (it will be
" waiting to see if the ESC is actually part of a key code like <F1>).
"
"set ttimeout
"
" personally, I find a tenth of a second to work well for key code
" timeouts. If you experience problems and have a slow terminal or network
" connection, set it higher. If you don't set ttimeoutlen, the value for
" timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
"
"set ttimeoutlen=100
endif

