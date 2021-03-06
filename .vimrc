" Sphantix's vimrc file.
"
" Maintainer: Sphantix
" Last change: 2016 Apri 15
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc
" for MS-DOS and Win32: $VIM\_vimrc
" for OpenVMS: sys$login:.vimrc

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" Vundle工具安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'fatih/vim-go'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mbbill/undotree'

" 可以通过以下四种方式指定插件的来源
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。
"Bundle 'L9'
Bundle 'a.vim'
Bundle 'The-NERD-tree'
Bundle 'Pydiction'

" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
Bundle 'majutsushi/tagbar'
Bundle 'wesleyche/SrcExpl'
Bundle "scrooloose/syntastic"
Bundle 'ctrlpvim/ctrlp.vim'

" c) 指定非Github的Git仓库的插件，需要使用git地址
"Bundle 'git://git.wincent.com/command-t.git'

" d) 指定本地Git仓库中的插件
"Bundle 'file:///Users/gmarik/path/to/plugin'
call vundle#end()            " required

" -----------------------------------------------------------------------------
"  < FileType 设置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp,*.h set tags+=~/.vim/tags/cpp        "omnicppcomplete" configure tags - add additional tags here or comment out not-used ones
au BufNewFile,BufRead,BufEnter *.py set tags+=~/.vim/tags/python  "omnicppcomplete" configure tags - add additional tags here or comment out not-used ones

" -----------------------------------------------------------------------------
"  < 环境配置 >
" -----------------------------------------------------------------------------
"let mapleader=","
syntax on
set ic
set background=dark
set history=50                                        " keep 50 lines of command line history
set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
colorscheme koehler
set tags+=tags;/
set autochdir
set ruler                                             " show the cursor position all the time
set showcmd                                           " display incomplete commands
set t_Co=256                                          " 256 colors

nmap <leader><c-v> "+gp
nmap <leader><c-c> "+y

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
set backspace=indent,eol,start                        " allow backspacing over everything in insert mode
set autoindent                                        " always set autoindenting on
" set nobackup                                        " do not keep a backup file, use versions instead
set backup                                            " keep a backup file
set fencs=utf-8,cp936
set autowrite                                         " automatically write current buffer
set autoindent                                        " autoindent
set smartindent
set guioptions=agirLt
set tabstop=4                                         " tab stop 2 spaces
set shiftwidth=4
set expandtab
set number 		                                	  " show line numbers
set fileformat=unix

" Don't use Ex mode, use Q for formatting
map Q gq

" -----------------------------------------------------------------------------
" < 搜索配置 >
" -----------------------------------------------------------------------------
set incsearch  "  increament search: like search in modern browsers
set hlsearch   "  Highlight search results
set ignorecase "  Ignore case when searching
set smartcase  "  When searching try to be smart about cases
set magic      "  For regular expressions turn magic on

" Only do this part when compiled with support for autocommands.
" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" -----------------------------------------------------------------------------
"  < 代码折叠 >
" -----------------------------------------------------------------------------
"用空格键来开关折叠
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set foldmarker={,}
set foldmethod=marker
set foldmethod=syntax
set foldlevel=100       " Don't autofold anything
set foldopen-=search   " don't open folds when you search into them
set foldopen-=undo     " don't open folds when you undo stuff

" -----------------------------------------------------------------------------
" < 文件打开后回到上次输入的地方 >
" -----------------------------------------------------------------------------
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" -----------------------------------------------------------------------------
"  < 自动补齐标点符号>
" -----------------------------------------------------------------------------
autocmd BufNewFile,BufRead,BufEnter *.* exec ":call AutoCompletePunctuation()"

func AutoCompletePunctuation()
    :inoremap ( ()<ESC>i
    :inoremap [ []<ESC>i
    if &filetype == "c" || &filetype == "cpp" || &filetype == "h" || &filetype == "cc" || &filetype == "hpp"
        :inoremap { {}<ESC>i<Enter><ESC><s-o>
    else
        :inoremap { {}<ESC>i
    endif
    :inoremap ' ''<ESC>i
    :inoremap " ""<ESC>i
    :inoremap < <><ESC>i
    :inoremap ) <c-r>=ClosePair(')')<CR>
    :inoremap } <c-r>=ClosePair('}')<CR>
    :inoremap ] <c-r>=ClosePair(']')<CR>
endfunc

func! ClosePair(char)
    if getline('.')[col('.') -1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" -----------------------------------------------------------------------------
"  < vim-airline 插件配置 >
" -----------------------------------------------------------------------------
let g:airline_theme='luna'

"打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"设置切换Buffer快捷键"
nnoremap <C-N> :bn<CR>
nnoremap <C-B> :bp<CR>

" 关闭状态显示空白符号计数,这个对我用处不大"
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#symbol = '!'

" -----------------------------------------------------------------------------
"  < undotree 插件配置 >
" -----------------------------------------------------------------------------
nmap <F5> :UndotreeToggle<cr>

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" -----------------------------------------------------------------------------
"  < NERDtree 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码
" 那里面列出了当前目录中的文件
"
"
"F8映射NERDTreeToggle快捷键
nmap <F8> :NERDTreeToggle<CR>

let NERDTreeWinPos = 'right'
let NERDTreeChDirMode=2

"如果NERDTree窗口是最后一个窗口则退出Vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" -----------------------------------------------------------------------------
"  < SrcExpl 插件配置 >
" -----------------------------------------------------------------------------
" 增强源代码浏览，其功能就像Windows中的"Source Insight
"F7映射NSrcExplToggle快捷键
nmap <F7> :SrcExplToggle<CR>

let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_prevDefKey = "<F11>"
let g:SrcExpl_nextDefKey = "<F12>"
let g:SrcExpl_isUpdateTags = 0

" -----------------------------------------------------------------------------
"  < DoxygenToolkit 插件配置 >
" -----------------------------------------------------------------------------
let g:DoxygenToolkit_briefTag_pre="@synopsis  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns   "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Hyman"
let g:DoxygenToolkit_licenseTag="GPL 2.0"

let g:DoxygenToolkit_authorName="hyman, 541844081@qq.com"
let s:licenseTag = "\<enter>\Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved"
let g:DoxygenToolkit_licenseTag = s:licenseTag
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
map <F2> :DoxAuthor <CR>
map <F3> :Dox <CR>

" -----------------------------------------------------------------------------
"  < OmniCppComplete 插件配置 >
" -----------------------------------------------------------------------------
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
set completeopt=menuone,menu,longest,preview

" -----------------------------------------------------------------------------
"  < NERD_commenter 插件配置 >
" -----------------------------------------------------------------------------
"let NERDShutUp=1

" -----------------------------------------------------------------------------
"  < vim-go 插件配置 >
" -----------------------------------------------------------------------------
" set mapleader
au FileType go let mapleader = ","

" vim-go custom mappings
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)

"let g:go_def_mapping_enabled = 0  "enable gd to jump definition
let g:go_fmt_command = "goimports"

" -----------------------------------------------------------------------------
"  < UltiSnips 插件配置 >
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -----------------------------------------------------------------------------
"  < syntastic 插件配置 >
" -----------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = '✗'      "set error or warning signs
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open= 1
let g:syntastic_check_on_close= 1
let g:syntastic_aggregate_errors = 1 " collect errors when use multple checkers
let g:syntastic_ignore_files=[".*\.py$"] "禁用syntastic来对python检查
" for c++
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" -----------------------------------------------------------------------------
"  < tagbar 插件配置 >
" -----------------------------------------------------------------------------
nmap <F6> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_compact = 1
let g:tagbar_singleclick = 1
let g:tagbar_autoshowtag = 1
"let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30

" go语言的tagbar配置
" 1.install gotags 'go get -u github.com/jstemmer/gotags'
" 2.make sure `gotags` in you shell PATH, you can call check it with `which gotags`
" for gotags. work with tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" -----------------------------------------------------------------------------
"  < ctrlp 插件配置 >
" -----------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" -----------------------------------------------------------------------------
"  < Pydiction 插件配置 >
" -----------------------------------------------------------------------------
au BufNewFile,BufRead,BufEnter *.py let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
au BufNewFile,BufRead,BufEnter *.py let g:pydiction_menu_height = 20

" -----------------------------------------------------------------------------
" < 创建新文件时自动加入文件头部 >
" -----------------------------------------------------------------------------
autocmd BufNewFile *.* exec ":call SetTitle()"
""function SetTitle
func SetTitle()
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."),"# author : sphantix")
        call append(line(".")+1, "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding: UTF-8 -*-")
        call append(line(".")+1,"# author : sphantix")
        call append(line(".")+2, "")
    else
        call setline(1, "/*")
        call append(line("."), " * File Name: ".expand("%"))
        call append(line(".")+1, " * Author: Sphantix")
        call append(line(".")+2, " * Mail: hangxu@antiy.cn")
        call append(line(".")+3, " * Created Time: ".strftime("%c"))
        call append(line(".")+4, " */")
        call append(line(".")+5, "")
    endif

    if expand("%:e") == 'cpp' || expand("%:e") == 'cc'
        call append(line(".")+6, "#include <string>")
        call append(line(".")+7, "")
    elseif expand("%:e") == 'c'
        call append(line(".")+6, "#include \"".expand("%:r").".h\"")
        call append(line(".")+7, "")
    elseif expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef __".toupper(expand("%:r"))."_H__")
        call append(line(".")+7, "#define __".toupper(expand("%:r"))."_H__")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
        call append(line(".")+10, "")
        call append(line(".")+11, "#endif /* __".toupper(expand("%:r"))."_H__ */")
    elseif expand("%:e") == 'hpp'
        call append(line(".")+6, "#ifndef __".toupper(expand("%:r"))."_HPP__")
        call append(line(".")+7, "#define __".toupper(expand("%:r"))."_HPP__")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
        call append(line(".")+10, "")
        call append(line(".")+11, "#endif /* __".toupper(expand("%:r"))."_HPP__ */")
    endif

    "after creating new file, go to the end of the file
endfunc
autocmd BufNewFile * normal G
