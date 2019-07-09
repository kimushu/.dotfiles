" ================================================================================
" kimu_shu's vimrc
" ================================================================================

" ----------------------------------------------------------------
" Encoding
"
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,ucs-2le,ucs-2
set nofixeol

" ----------------------------------------------------------------
" For Vundle.vim
" (git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim)
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" List of bundled plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-utils/vim-man'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neocomplete'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/vinarise'
Plugin 'majutsushi/tagbar'
Plugin 'simeji/winresizer'
Plugin 'davidhalter/jedi-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'digitaltoad/vim-pug'
Plugin 'shohei/vim-eagle-ulp'
Plugin 'mmalecki/vim-node.js'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomtom/tcomment_vim'
Plugin 'concise/vim-guess-indent'
Plugin 'leafgarland/typescript-vim'

call vundle#end()             " required
syntax enable
filetype plugin indent on     " required

" ----------------------------------------------------------------
" Appearance
"
set ts=4
set sw=4
set number
set list
set listchars=tab:>\ ,trail:-
set nowrap
set t_Co=256
set laststatus=2
set wildmenu
set wildmode=longest:full
colorscheme jellybeans

" ----------------------------------------------------------------
" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" ----------------------------------------------------------------
" Mouse
set mouse=a
set ttymouse=xterm2

" ----------------------------------------------------------------
" For vim-airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'

" ----------------------------------------------------------------
" For vim-man
"
nnoremap K :Man <C-R><C-W><CR>

" ----------------------------------------------------------------
" For neocomplete
"
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern

" Recommended key-mappings
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "")."\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" ----------------------------------------------------------------
" For neosnippet
"
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
set conceallevel=2 concealcursor=niv

" ----------------------------------------------------------------
" For Vinarise
"
"FIXME: This blocks gzip functionality :-(
"augroup BinaryXXD
"  autocmd!
"  autocmd BufReadPre   *.bin let &binary=1
"  autocmd BufReadPost  * if &binary | Vinarise
"  autocmd BufWritePre  * if &binary | Vinarise | endif
"  autocmd BufWritePost * if &binary | Vinarise
"augroup END

" ----------------------------------------------------------------
" For tagbar
"
let g:tagbar_width = 28
nnoremap <silent> <leader>t :TagbarToggle<CR>

" ----------------------------------------------------------------
" For jedi-vim
"
autocmd FileType python setlocal completeopt-=preview

" ----------------------------------------------------------------
" For filetype preferences
"
autocmd FileType coffee setlocal et sts=2 sw=2
autocmd FileType javascript setlocal et sts=2 sw=2
autocmd FileType json setlocal et sts=2 sw=2
autocmd FileType pug setlocal et sts=2 sw=2

" ----------------------------------------------------------------
" For vim-indent-guides
"
"let g:indent_guides_enable_on_vim_startup = 1

" ----------------------------------------------------------------
" Other key bingings
"

" shell invoke
map <C-\> :shell<CR>

" Ignore Shift
noremap <ESC>[1;2A <Up>
noremap <ESC>[1;2B <Down>
noremap <ESC>[1;2C <Right>
noremap <ESC>[1;2D <Left>
inoremap <ESC>[1;2A <Up>
inoremap <ESC>[1;2B <Down>
inoremap <ESC>[1;2C <Right>
inoremap <ESC>[1;2D <Left>

" Row scroll (Ctrl+U/D)
noremap <ESC>[1;5A <C-Y>
noremap <ESC>[1;5B <C-E>
inoremap <ESC>[1;5A <C-O><C-Y>
inoremap <ESC>[1;5B <C-O><C-E>

" Word jump (Ctrl+L/R)
noremap <ESC>[1;5C w
noremap <ESC>[1;5D b
inoremap <ESC>[1;5C <C-O>w
inoremap <ESC>[1;5D <C-O>b

" Window jump (Shift+L/R)
noremap <ESC>[1;6A <C-W><Up>
noremap <ESC>[1;6B <C-W><Down>
noremap <ESC>[1;6C <C-W><Right>
noremap <ESC>[1;6D <C-W><Left>

" Tab jump
noremap @[ gt
noremap <ESC>[1;3C gt
noremap [@ gT
noremap <ESC>[1;3D gT

" Disable highlights
noremap <silent> <ESC>[34~ :noh<CR>

" vim: set et sts=2 sw=2:
