" appearance.vim
" segmented neovim config file
" specific to handling appearance settins that are seperate to colorschemes

" TODO: Implement more stuff from this http://bit.ly/2fxEW5T
set termguicolors

" TODO: Figure out way to set local theme seperate from git-tracked settings
colorscheme PaperColor

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" airline congigs
" ----------------------------------------------------------
" change maxlinenr to nothing because I can't find unicode 0133 (3310?)
" TODO: remove maxlinenr
let g:airline_symbols = get(g:,'airline_symbols',{})
let g:airline_symbols.maxlinenr=''
" include buffer number (BN:)
let g:airline_section_y = 'BN: %{bufnr("%")}'
" this comes from w0rp/ale linter to show error/warnings in status line
let g:airline#extensions#ale#enabled = 1

" indentline
let g:indentLine_enabled = 0
let g:indentLine_char = '¦'




" time-based color settings (change @ 5p 1700)
" ----------------------------------------------------------
set background=dark
if strftime("%H") > 6
  if strftime("%H") < 17
    set background=light
  endif
endif

set guicursor=n-v-c:block-Cursor
