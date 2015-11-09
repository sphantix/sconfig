" Hyman's vimrc file.
" 
" Maintainer: Hyman 
" Last change: 2015 Aug 1
"
" To use it, copy it to
" for Unix and OS/2: ~/.vimrc
" for Amiga: s:.vimrc 
" for MS-DOS and Win32: $VIM\_vimrc 
" for OpenVMS: sys$login:.vimrc 

" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

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

" 可以通过以下四种方式指定插件的来源  
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。  
"Bundle 'L9'  
Bundle 'a.vim'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree' 

" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定  
"Bundle 'tpope/vim-fugitive'  
"Bundle 'Lokaltog/vim-easymotion'  
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}  
"Bundle 'tpope/vim-rails.git'
Bundle 'wesleyche/SrcExpl'
  
" c) 指定非Github的Git仓库的插件，需要使用git地址  
"Bundle 'git://git.wincent.com/command-t.git'  
  
" d) 指定本地Git仓库中的插件  
"Bundle 'file:///Users/gmarik/path/to/plugin'
call vundle#end()            " required

" -----------------------------------------------------------------------------
"  < 环境配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进
set background=dark
au BufNewFile,BufRead *.php,*.module,*.install,*.php\d		setf php
set history=50                                        " keep 50 lines of command line history 
set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
colorscheme koehler
set tags+=tags;/
autocmd FileType cpp set tags+=~/.vim/tags/cpp        "omnicppcomplete" configure tags - add additional tags here or comment out not-used ones
autocmd FileType python set tags+=~/.vim/tags/python  "omnicppcomplete" configure tags - add additional tags here or comment out not-used ones
set autochdir
set ruler                                             " show the cursor position all the time 
set showcmd                                           " display incomplete commands 

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
set backspace=indent,eol,start                        " allow backspacing over everything in insert mode 
set autoindent                                        " always set autoindenting on 
" set nobackup                                        " do not keep a backup file, use versions instead 
set backup                                            " keep a backup file 

set fencs=utf-8,cp936
set incsearch                                         " do incremental searching 
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

" This is an alternative that also works in block mode, but the deleted 
" text is lost and it only works for putting the current register. 
"vnoremap p "_dp 

" Switch syntax highlighting on, when the terminal has colors 
" Also switch on highlighting the last used search pattern. 
if &t_Co > 2 || has("gui_running") 
 set hlsearch 
endif 

" Only do this part when compiled with support for autocommands. 
if has("autocmd") 
" For all text files set 'textwidth' to 78 characters. 
autocmd FileType text setlocal textwidth=78 
endif

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

syntax on
set ic
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
"  < 自动补齐>
" -----------------------------------------------------------------------------
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i<Enter><ESC><s-o>
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap < <><ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap ' <c-r>=ClosePair(''')<CR>
":inoremap " <c-r>=ClosePair('"')<CR>
func! ClosePair(char)
    if getline('.')[col('.') -1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" -----------------------------------------------------------------------------
"  < TagList 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码, 其功能就像vc中的workpace
" 那里面列出了当前文件中的所有宏,全局变量, 函数名等

"F8映射taglist快捷键
nmap <F8> :Tlist<CR>

let Tlist_Show_One_File=1                   "只显示当前文件的tags
let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠

" -----------------------------------------------------------------------------
"  < NERDtree 插件配置 >
" -----------------------------------------------------------------------------
" 高效地浏览源码
" 那里面列出了当前目录中的文件
"
"
"F8映射NERDTreeToggle快捷键
nmap <F9> :NERDTreeToggle<CR>

let NERDTreeWinPos = 'right'
let NERDTreeChDirMode=2

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

"doxygen toolkit 
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

" OmniCppComplete
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

" OmniCppComplete also support completing other language
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

"对NERD_commenter的设置
"let NERDShutUp=1
