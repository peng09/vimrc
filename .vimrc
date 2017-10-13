set nocompatible              " be iMproved, required
set autoread

execute pathogen#infect()

" Editor's general settings
set clipboard=unnamed
set backspace=indent,eol,start
set number
set mouse+=a
set listchars=tab:>·,trail:~
set list
set hidden
let mapleader="`"

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

filetype plugin indent on

set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1

" Syntastc settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_auto_loc_list             = 2
let g:syntastic_check_on_open             = 1
let g:syntastic_check_on_wq               = 0

let g:syntastic_auto_jump                 = 1
let g:syntastic_enable_balloons           = 1
let g:syntastic_always_populate_loc_list  = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_c_checkers = ['gcc']

"let g:syntastic_mode_map = {
"    \ 'mode': 'passive',
"    \ 'active_filetypes': [],
"    \ 'passive_filetypes': [] }
nnoremap <Leader>e :SyntasticCheck<CR>

function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction

nnoremap <silent> <F7> :<C-u>call ToggleErrors()<CR>

" Easymotion settings

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" <Leader>s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Solarized settings
syntax on
set background=dark
colorscheme solarized

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <F9> :NERDTreeToggle<CR>
nnoremap <F10> :NERDTree .<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" NERDCommenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Tagbar settings
nmap <F8> :TagbarToggle<CR>

" Ctrlp.vim settings
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
nnoremap <C-n> :bn<CR>

" YCM settings
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <Leader>b :YcmCompleter GoTo<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"" turn on completion in comments
let g:ycm_complete_in_comments=1
"" only show completion as a list instead of a sub-window
set completeopt-=preview
"" compatible with syntastic for C-family languages
let g:ycm_show_diagnostics_ui = 0

" Fugitive git bindings
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

" bbye settings
nnoremap <Leader>q :Bdelete<CR>

" Ack settings
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" MARKDOWN settings
let g:vim_markdown_folding_disabled = 1

" Tabular settings
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
nmap <Leader>t :Tabularize
vmap <Leader>t :Tabularize

" Github settings
let g:github_enterprise_urls = ['https://github.prod.hulu.com']

" Custom settings
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
vnoremap <Leader>p "_dP
inoremap { {}<Esc>i
inoremap [ []<Esc>i
nnoremap <Leader>i gg=G
nmap <c-s-t> :vs<bar>:b#<CR>

