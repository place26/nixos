" General Settings: {{{

" set termguicolors
" if !has('gui_running')
"     set t_Co=256
" endif
if has('termguicolors')
    set termguicolors
endif

set nocompatible                                        " make vim more powerful
filetype plugin indent on
filetype plugin on
syntax on
set mouse=a                                             " support mouse
set confirm                                             " ask before unsage action

" ssh 사용시 발생할 수 있는 문제 예방
set noswapfile nobackup                                 " don't use swap file
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=$HOME/.vim/undo-dir
set undofile

set encoding=utf-8
set clipboard=unnamed,unnamedplus                       " 외부 clipboard 이용
set number relativenumber                               " with relativenumber, show current number

set showcmd
set noshowmode
set wildmenu
set wildmode=longest,list,full

set smarttab tabstop=4 softtabstop=4 shiftwidth=4       " width of a tab character
set smartindent
set expandtab

set ignorecase smartcase
set incsearch hlsearch
set gdefault
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\
set wrap breakindent
set title
set backspace=indent,start,eol                          " <BS> 역할설정, eol 제외
set scrolloff=8                                         " during scroll keep 3 lines be shown"
set laststatus=2                                        " always show status line
set cursorline                                          " highlight the line with a cursor
set list
set listchars=tab:▸\ ,trail:⋅,extends:>,precedes:<,eol:¬,nbsp:_

" To use fzf in Vim, add the following line to your .vimrc:
set rtp+=/opt/homebrew/opt/fzf

" Disable cursor line highlighting in Insert mode
augroup aug_cursor_line
   au!
   au InsertEnter * setlocal nocursorline
   au InsertLeave * setlocal cursorline
augroup END

" gopass에서 vim을 사용하는 경우 보안을 위해 반드시 추가
autocmd BufNewFile,BufRead /private/**/gopass** setlocal noswapfile nobackup noundofile viminfo=""

"}}}

" Custom Key Mappings: {{{

" Set <leader> key to <Space>
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" FZF : Ctrl-p로 FZF picker interface를 열기 
" start typing, automatically find results
" navigation through the resuls : <C-k>, <C-j>
" select <CR> current window, <C-x> horizontal, <C-v> vertical,
" <C-t> new tab page, <C-c> dismiss
nnoremap <C-p> :<C-u>FZF<CR>


" iPad를 위해 <ESC>를 키 매핑, 무척 편리함. set paste와 같이 쓸 경우 안됨.
inoremap jk <ESC>

" Terminal: i로 시작, exit로 빠져나옴
nmap <leader>s <C-w>s<C-w>j:terminal<CR>
nmap <leader>vs <C-w>v<C-w>l:terminal<CR>

" AutoComplPop: keymapping {{{
" 타이핑을 시작하면 자동으로 팝업메뉴가 떠서 선택할 수 있는 플러그인
" Navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" Select the complete menu item like CTRL+y would.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

" Cancel the complete menu item like CTRL+e would.
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"
" }}}

" }}}

" Plugins Install: {{{

call plug#begin()

    " Vim Make Pretty:
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/gruvbox-material'
    Plug 'ryanoasis/vim-devicons'

    " Vim Make Friendly:
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Language
    Plug 'sheerun/vim-polyglot'

    " Shell:
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'samoshkin/vim-lastplace'              " 파일을 열때 마지막 상태로 불러들임

    " Search:
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-slash'                   " 검색된 결과를 강조(highlight), 커서가 벗어나면 강조해제
    Plug 'dyng/ctrlsf.vim'                      " :CtrlSF {pattern} ~/Sync
    Plug 'mileszs/ack.vim'                      " ag를 이용한 search :Ack

    " GIT:
    Plug 'tpope/vim-fugitive'                   " git plugin
    Plug 'airblade/vim-gitgutter'               " show git diff in the 'gutter' (sign colume)
    
    " Keyboard:
    " Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'                 " pair brackets,parens,quotes
    Plug 'vim-scripts/AutoComplPop'             " https://www.youtube.com/watch?v=2f8h45YR494
    Plug 'terryma/vim-smooth-scroll'            " C-u(p)|d(own)|b(ack)|f(ront)
    Plug 'tpope/vim-surround'                   " mapping to easily delete, change and add such surroungings in pairs
                                                " surroundings: parentheses, brackets, quotes, XML tabs and more
                                                " cs, ds, ys가 기본 명령어
                                                " cs"' | cs'<q> | ds" - delete " | ysiw* | ys2w* - 두단어를 *로 둘러쌈
                                                " yss* - entire line
                                                " select line (S-v) --> S<p class="important">
                                                " or yss)|ysiw<em>|visual mode S<p class="important">
    " Plug 'svermeulen/vim-yoink'                 " :Yoinks - select one,
                                                " after paste C-p|C-n to change selection

    " VimWiki:
    Plug 'vimwiki/vimwiki'                      " <leader>ww|wt|w<leader>
    Plug 'SirVer/ultisnips'                     " insert mode - <F9> - then fuzzy select
                                                " normal mode - <F9> - then edit snippets
    Plug 'honza/vim-snippets'


call plug#end()

" }}}

" Simple Plugin Configurations: {{{

set background=dark
" Color Scheme Settings :Colors로 변경 가능
" italic 문자를 지원하지 않는 폰트를 선택한 경우, 아래 옵션을 선택한 경우
" comment가 inverted로 보임
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
let g:lightline = { 'colorscheme' : 'gruvbox_material' }
" 위의 두라인이 반드시 먼저 위치해야 함.
colorscheme gruvbox-material
 
" colorscheme Tomorrow-Night

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1
let g:airline_theme = 'sonokai'
" comment line이 invert로 보이는 현상 방지를 위해 포함.
let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai

" AutoComplPop: 관련 설정
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c

" Airline:
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

" NerdTree
noremap  <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

" Ctrl p ignore list
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$\|node_modules$',
\ 'file': '\v\.(exe|so|dll)$'
\ }

" }}}

" Folding: {{{

" 속도 문제가 발생, 파일오픈 시 unfolded로 불러들임.
set foldenable
set foldmethod=marker
set foldlevelstart=1
" set foldcolumn=1

" What triggers automatic fold opening
set foldopen-=block
set smartindent
set foldopen-=hor
set foldopen+=jump

" Remap because 'za' is highly inconvenient to type
nnoremap <leader><Space> za
" Remap folds everything all the way: fold-close-all
nnoremap <leader>za zM
" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>fce zMzvzz

" }}}

" Window Management: {{{

" Navigate between windows
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-l> :wincmd l<CR>

" Use <Bslash> instead of <C-w>, which is tough to type
nmap <Bslash> <C-w>

" Splits: default splitabove
set splitbelow
set splitright
nnoremap <silent> <leader>_ :split<CR>
nnoremap <silent> <leader>\| :vsplit<CR>
nnoremap <silent> <leader>0 :only<CR>

" Maximize Split: Use '<C-w>=' to make window sizes equal back
nnoremap <C-w><Bslash> <C-w>_<C-w>\|

" Tab Navigation:
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>

" Tab Management:
nnoremap <silent> <leader>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <leader>) :tabonly<CR>
nnoremap <silent> <leader>- :tabclose<CR>

" }}}

" Vim Commentary: {{{

" add comment string as filetype
autocmd FileType vim setlocal commentstring=\"\ %s
autocmd FileType apache setlocal commentstring=#\ %s

" Comment line and move 1 line down
nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary

" }}}

" VimWiki: {{{

" " disable folding: '', 'expr', 'synctax', 'list'
" let g:vimwiki_folding = ' '
" let g:vimwiki_global_ext=0
" let g:vimwiki_hl_cb_checked=2

" change [Enter] key to <leader>l
" nmap <leader>l <Plug>VimwikiFollowLink
" nmap <localleader>l <Plug>VimwikiFollowLink
" <tab> 키를 이용한 table 정렬을 취소
let g:vimwiki_table_mappings = 0
let g:vimwiki_conceallevel = 2

" vimwiki를 위한 wrap 설정
au BufRead,BufNewFile *.wiki setlocal textwidth=99
au BufRead,BufNewFile *.wiki setlocal formatoptions+=w
au BufRead,BufNewFile *.md setlocal textwidth=99
au BufRead,BufNewFile *.md setlocal formatoptions+=w

" VimWikiWrap:
nnoremap <leader>vww gqip
nnoremap <leader>vdg :VimwikiDiaryGenerateLinks<CR>

" syncthing 공유 폴더를 활용
" 두개의 wikilist를 사용, 두번째는 huahan 전용 markdown syntax 사용
let g:vimwiki_list = [
      \{
      \  'path'               : '~/FutureIM/VimWiki/',
      \  'syntax'             : 'markdown',
      \  'ext'                : '.md',
      \  'auto_diary_index'   : 1,
      \},
      \{
      \  'path'               : '~/FutureIM/PatientsNotes/',
      \  'auto_tags'          : 1,
      \  'auto_diary_index'   : 1,
      \},
      \{
      \  'path'               : '~/FutureIM/BuildDream/',
      \  'auto_tags'          : 1,
      \  'auto_diary_index'   : 1,
      \},
\]

hi VimwikiHeader1 cterm=bold term=bold gui=bold guifg=#FF7B25
hi VimwikiHeader2 cterm=bold term=bold gui=bold guifg=#82B74B
hi VimwikiHeader3 cterm=bold term=bold gui=bold guifg=#92A8D1
hi VimwikiHeader4 cterm=bold term=bold gui=bold guifg=#F18973
hi VimwikiHeader5 cterm=bold term=bold gui=bold guifg=#F4A688
hi VimwikiHeader6 cterm=bold term=bold gui=bold guifg=#B8A9C9

" " g:vimwiki_folding to 'Custom' {{{
" " 도움에서 복사 한 항목
"   function! VimwikiFoldLevelCustom(lnum)
"         let pounds = strlen(matchstr(getline(a:lnum), '^#\+'))
"         if (pounds)
"           return '>' . pounds           " start a fold level
"         endif
"         if getline(a:lnum) =~? '\v^\s*$'
"           if (strlen(matchstr(getline(a:lnum + 1), '^#\+')))
"                 return '-1'                             " don't fold last blank line before header
"           endif
"         endif
"         return '='                                      " return previous fold level
"   endfunction
"   augroup VimrcAuGroup
"         autocmd!
"         autocmd FileType vimwiki setlocal foldmethod=expr |
"           \ setlocal foldenable | set foldexpr=VimwikiFoldLevelCustom(v:lnum)
"   augroup END
"   " }}}

" }}}

" Emoji shortcuts
ab :check_mark: ✅
ab :warning: ⚠️A
ab :bulb: 💡
ab :pushpin: 📌
ab :bomb: 💣
ab :pill: 💊
ab :construction: 🚧
ab :pencil: 📝
ab :point_right: 👉
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :info: 🛈
ab :telephone: 📞
ab :email: 📨
ab :computer: 💻
ab :smile: 😃
ab :cold_sweat: 😰
ab :smile_sweat: 😅
ab :scary: 😱


