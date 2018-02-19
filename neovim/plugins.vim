" plugins.vim
" plugin-specific configurations
" TODO: split particularly large sets into their own file as needed


" NERDTree keymaps
" ----------------------------------------------------------
"  Automatically close NERDTree pane after selection
let NERDTreeQuitOnOpen=1
" Toggle NERDTree with leader + t
nnoremap <leader>t :NERDTree<CR>:NERDTreeFocus<CR>
nnoremap <leader>T :NERDTreeFocus<CR>

" ALE Linting options : http://bit.ly/2wY3Kr3
" ----------------------------------------------------------
"  linters
let g:ale_linters = {
\  'javascript': ['eslint'],
\}
" enable filetypes using the associated linting program
" Recently changed to test if using npx enforces local linters instead of global
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\}
" lint on saves
let g:ale_fix_on_save = 1
" TODO: test with flow on non typescript
" let g:ale_completion_enabled = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file


" Deoplete
" ----------------------------------------------------------
"  Non-display airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"  Enable deoplete
let g:deoplete#enable_at_startup = 1
" Autocmd to conditionally enable deoplete using tab, c-n and ...?
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Check for OS type, if mac then set python path
if has('macunix')
  let g:python2_host_prog = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif


" NERDCommenter
" ----------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multiline comments
let g:NERDCompactSexyComs = 1
" Align linewise comment delimiters flush left instead of following indents
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful for commenting regions)
let g:NERDCommentEmptyLines = 1
" Trim trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


"  Non-display airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" vim-javascript & vim-jsx
" syntax highlighting for jsdocs
let g:javascript_plugin_jsdoc = 1
" enable working with flow
let g:javascript_plugin_flow = 1
" code folding based on syntax file of plugin
set foldmethod=syntax
" for jsx....
" enable jsx handling of js extension as well
let g:jsx_ext_required = 0
" concealing settings
set conceallevel=1
map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "⇒"
let g:javascript_conceal_underscore_arrow_function = "⇒"

" vim-markdown-composer
" ---------------------
"  Turn off automatic opening of the specified browser
let g:markdown_composer_open_browser = 0

