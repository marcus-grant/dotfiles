" neovim keymap configs file
" segmented config file specific to setting up keymaps


""" Leader Maps (Global ones) {{{
" ------------------------------------------------------------------------------
"  leader is comma key (while in normal mode)
let mapleader=","
" disable search highlights with leader+h
nnoremap <leader>h :noh<cr>
" }}}

""" Pane Controls {{{
" pane splits <leader>+\ splits right, <leader>+- splits down
nnoremap <leader>\ <C-w>v
nnoremap <leader>- <C-w>s
" pane switching using Ctrl+(h/j/k/l)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" pane selection inside insert mode
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l
" pane selection inside term
" from http://bit.ly/2jTmoOO r/neovim post about pane controls
" TODO: good resource, but needs validation
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" pane selection that is aware of https://github.com/christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-p> :TmuxNavigatePrevious<cr>
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" TODO: Max out height of current split
"nnoremap <leader>_ <C-w>_
"nnoremap <leader>| <C-w>|
" equalize split sizes, useful for resizing terminal
nnoremap <leader>= <C-w>=
" swap splits
nnoremap <leader>s <C-w>r

"}}}

" text modification scripts {{{
"================================
" Clear the currently cursor'd line
nnoremap -d dd
" Clear the currently cursor'd line & go to insert mode (double c's)
nnoremap -c ddO
" Insert newline without entering insert mode
" }}}

""" Terminal Buffer Keymaps {{{
if has('nvim')
    " Make esc leave terminal mode
    tnoremap <Esc> <C-\><C-n>
    tnoremap kj <C-\><C-n>

    " Easy moving between the buffers
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " Try and make sure to not mangle space items
    tnoremap <S-Space> <Space>
    tnoremap <C-Space> <Space>
  endif
" }}}

" fzf {{{
"================================
nnoremap <leader>f :Files<cr>
" }}}

""" Copy to Clipboard {{{
set clipboard+=unnamedplus
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
"}}}

"================================
" Go maps
"================================
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
" Go to the definition of something using F12
au FileType go nmap <F12> <Plug>(go-def)
au FileType go nmap <F10> :GoTest -short<cr>
" bring up test coverage mode
au FileType go nmap <F11> :GoCoverageToggle -short<cr>
" Jump to definition using F12
" TODO check if this can be replaced with C-g for all filetypes
au FileType go nmap <C-g> <Plug>(go-def)
" Keys to make debugging & running in delve a bit more pleasant
" These are typical keys for most IDE's when debugging and running
" F5 to run & to continue debugging
au FileType go nmap <F5> :w<cr>:DlvDebug<cr>
au FileType go nmap <F9> :DlvToggleBreakpoint<cr>
" TODO: Add more later, and also consider them for other languages in debug

