"
" NeoVim configuration file
"

" Plugin manager
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'tikhomirov/vim-glsl'
call plug#end()

" Appearance
set nu
set t_Co=256
colorscheme wal

" Whitespaces & tabs are shown
set list
highlight Trail ctermbg=red ctermfg=black guibg=red
call matchadd('Trail', '\s\+$', 100)
" let c_space_errors = 1

" Common stuff
syntax on
set clipboard+=unnamedplus
set fileencodings=utf8,cp1251,cp1252

" .h is C header!
autocmd BufRead,BufNewFile *.h,*.c set filetype=c

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !textcomp.sh <c-r>%<CR>

map <C-n> :NERDTreeToggle<CR>

" Fuzzy finder
let g:ctrlp_map = '<c-f>'
let g:ctrlp_open_func = { 'files': 'ctrlp#stuff#FileOpener' }
set wildignore+=*.o,*.a,*.elf

" Switch between header and c file
nnoremap r :A<CR>

" Run make on space press
noremap <Space><Space> :make!<cr>

