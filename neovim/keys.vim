" neovim keymap configs file
" segmented config file specific to setting up keymaps


" leader keymaps
" ------------------------------------------------------------------------------
"  leader is comma key (while in normal mode)
let mapleader=","
" disable search highlights with leader+h
nnoremap <leader>h :noh<cr>

" text modification scripts
" ------------------------------------------------------------------------------
" Clear the currently cursor'd line
nnoremap -d dd
" Clear the currently cursor'd line & go to insert mode (double c's)
nnoremap -c ddO
" Insert newline without entering insert mode


" pane controls
" ------------------------------------------------------------------------------
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

" fzf
nnoremap <leader>f :Files<cr>
