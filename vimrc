" -------------------------------------------------------------------
" Get OS type
" -------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -------------------------------------------------------------------
" Get GUI state
" -------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" -----------------------------------------------------------------------------
" Windows gVim options
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()
 
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif
 
" -----------------------------------------------------------------------------
" Linux Vim/gVim options
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch
    set incsearch
 
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
 
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
 
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
 
        set mouse=a
        set t_Co=256
        set backspace=2
 
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" -----------------------------------------------------------------------------
" Plugins configured by Vundle
" -----------------------------------------------------------------------------
" Install Vundle first:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set nocompatible
filetype off

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle
    call vundle#rc('$VIM/vimfiles/bundle')
endif

Bundle 'gmarik/vundle'
Bundle 'a.vim'
Bundle 'Align'
Bundle 'jiangmiao/auto-pairs'
Bundle 'bufexplorer.zip'
Bundle 'ccvext.vim'
Bundle 'cSyntaxAfter'
Bundle 'Mizuchi/STL-Syntax'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'Yggdroot/indentLine'
Bundle 'vim-javacompleteex'
Bundle 'vim-scripts/matchit.zip'
Bundle 'Mark--Karkat'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'OmniCppComplete'
Bundle 'Lokaltog/vim-powerline'
Bundle 'repeat.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'wesleyche/SrcExpl'
Bundle 'std_c.zip'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'taglist.vim'
Bundle 'TxtBrowser'
Bundle 'ZoomWin'
Bundle 'wesleyche/Trinity'
Bundle 'yegappan/grep'
Bundle 'jenrryt/vim-linux-coding-style'
Bundle 'asins/vimcdoc'
Bundle 'uguu-org/vim-matrix-screensaver'
Bundle 'altercation/vim-colors-solarized'
Bundle 'dante.vim'
Bundle 'jenrryt/asu1dark.vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'tomasr/molokai'

" -----------------------------------------------------------------------------
" Encoding configurations
" -----------------------------------------------------------------------------
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
if g:iswindows
    set fileencoding=gbk
else
    set fileencoding=utf-8
endif

set fileformats=unix,dos,mac
set helplang=cn
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>
nmap <leader>fm :se ff=mac<cr>

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
" Editing Configurations
" -----------------------------------------------------------------------------
filetype on
filetype plugin on
filetype plugin indent on
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoread
let mapleader=","

" set foldenable
" set foldmethod=indent
" set foldmethod=marker
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

nmap cS :%s/\s\+$//g<CR>:noh<CR>
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase
set smartcase
set incsearch

nmap <silent> <F11> :nohl<CR>
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
if g:iswindows
    map <leader>e :e! $VIM/_vimrc<cr>
else
    map <leader>e :e! ~/.vimrc<cr>
endif

" Quickfix
nmap <F6> :cn<CR>
nmap <F7> :cp<CR>
noremap <silent> <leader>do :copen<CR>
noremap <silent> <leader>dc :cclose<CR>

" Buffers
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" grep
nnoremap <silent> <F3> :Grep<CR>

" -----------------------------------------------------------------------------
" Interface Configurations
" -----------------------------------------------------------------------------
set number
set laststatus=2
set cmdheight=2
set nowrap
set nobackup
set wildmenu
set ruler
set noerrorbells
set novisualbell
set t_vb=
set autochdir
set shortmess=atI

if g:isGUI
    set guioptions-=T
    set cursorline
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
    set columns=160
    set lines=60
    if g:islinux
        set gfn=DejaVu\ Sans\ Mono\ 11
    else
        set gfn=DejaVu_Sans_Mono:h11
    endif

    colorscheme solarized
    set background=dark
else
    colorscheme Tomorrow-Night
endif

" -----------------------------------------------------------------------------
" Plugin Configurations
" -----------------------------------------------------------------------------
" indentline
nmap <leader>il :IndentLinesToggle<CR>
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif
let g:indentLine_color_term = 239
"let g:indentLine_color_gui = '#A4E57E'

" OmniCppComplete
set completeopt=menu

" std_c
let c_cpp_comments=0

" Tagbar
nmap tb :TlistClose<CR>:TagbarToggle<CR>

" Taglist
nmap tl :TagbarClose<CR>:Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_WinWidth=30
"let Tlist_Use_Right_Window=1
let Tlist_Compact_Format=1
let Tlist_Process_File_Always=1

" Trinity
nmap <F8> :TrinityToggleAll<CR>

" neocomplcache
let g:neocomplcache_enable_at_startup=1

" nerdcommenter
let NERDSpaceDelims=1

" nerdtree
nmap nt :NERDTreeToggle<CR>

" cscope
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" ctags
set tags=tags;

" kernel-coding-style
let g:linuxsty_patterns = ["/linux", "/kernel/"]
nmap <silent> <leader>k :LinuxCodingStyle<CR>

" -----------------------------------------------------------------------------
" Special filtype configurations
" -----------------------------------------------------------------------------
autocmd filetype yaml setlocal si et sta sw=2 sts=2
autocmd filetype php setlocal si et sta sw=2 sts=2
autocmd filetype xhtml setlocal si et sta sw=2 sta=2
autocmd filetype c setlocal et
autocmd filetype cpp setlocal et
