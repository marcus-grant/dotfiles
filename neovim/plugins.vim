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

"================================
" ALE Linting options : http://bit.ly/2wY3Kr3
"================================
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
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file


" Deoplete
" ----------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 2
" Autocmd to conditionally enable deoplete using tab, c-n and ...?
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Coordinate completion plugins
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
" let g:deoplete#omni#functions.javascript.jsx = [
"   \ 'tern#Complete',
"   \ 'jspc#omni'
" \]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources.javascript = ['buffer', 'file', 'ultisnips', 'tern']
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#file#enable_buffer_path=1
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]

" TODO: this might be an odd addition
if exists('g:plugs["tern_for_vim"]')
  " Enable excellent keyboard shortcuts
  let g:tern_map_keys=1
  " Display argument type hints when the cursor is left over a function
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" Python sourcing
let g:deoplete#sources#jedi#server_timeout = 6

" autocomplete
" autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType go let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-n>"
let g:UltiSnipsExpandTrigger="<C-j>"
"
" TODO: shouldn't this be reversed?
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Improvement to make the preview window close after PUM dissapears
" From http://bit.ly/2wxYLSi
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Bind the PopUpMenu for deoplete to deal better with ultisnips
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" deoplete + neosnippet + autopairs - taken from http://bit.ly/2BFJFem
" let g:AutoPairsMapCR=0
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Check for OS type, if mac then set python path
if has('macunix')
  let g:python2_host_prog = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

" Ultisnips

if g:my_snippet_manager == 'ultisnips'
    let g:UltiSnipsExpandTrigger="<C-j>"

    " Configuration for custom snips
    " let g:UltiSnipsSnippetsDir = "~/dotfiles/neovim/snips"
    " let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]
    "
    " Trigger configuration
    " let g:UltiSnipsExpandTrigger='<tab>'
    " let g:UltiSnipsJumpForwardTrigger='<C-r>'
    " let g:UltiSnipsJumpBackwardTrigger='<C-q>'
    "
    " How to open ultisnips ediiting
    " let g:UltiSnipsEditSplit = 'vertical'
    "
    " Configure snips to use python3
    " let g:UltiSnipsUsePythonVersion = 3
else
	echoerr "You have set an invalid value for `g:my_snippet_manager`"
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
" From https://bit.ly/2kp8npv
" Used to recognize & handle jsx comments
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' } }



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


"Go settings  {{{
"================================
"    highlighting settings
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" TODO: Look into a disable sameid highlighter key
let g:go_auto_sameids = 1 " nifty highlighter for same named entities
" auto import of new deps - with this, on save go will import the deps
let g:go_fmt_command = "goimports"
" linting is handled in ALE section
" JSON tagging and transform to make JSON work easier
" let g:go_addtags_transform = "camelcase"
" reveal types by hovering cursor
" TODO some massive errors occur with this plugin when using this option
" Check back here on this issue to see any new updates that might arise
" For now it must be disbaled - Link: http://bit.ly/2pGfgpC
" let g:go_auto_type_info = 1
" Go snips engine
let g:go_snippet_engine = "ultisnips"
"}}}
" Mardown

" vim-pandoc {{{
"================================
let g:pandoc#syntax#conceal#urls = 1
" let g:pandoc#folding#level = 2
let g:pandoc#syntax#colorcolumn = 0
" let g:pandoc#formatting#mode = "ha"
" fixes irritating fold column on left https://github.com/vim-pandoc/vim-pandoc/issues/200
let g:pandoc#folding#fdc = 0
" leave spelling off by default & enable it by opting in
set nospell
" }}}

" vim-markdown-composer {{{
" ---------------------
"  Turn off automatic opening of the specified browser
let g:markdown_composer_open_browser = 0
" }}}

" custom plugin to detect & highlight docker files
"================================
" Detect the filetype
au BufNewFile,BufRead [Dd]ockerfile,Dockerfile.*,*.Dockerfile set filetype=dockerfile
" Apply the highlighting rules
source ~/.config/nvim/syntax/dockerfile.vim

" vim-test {{{
"================================
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'neovim',
  \ 'suite':   'basic',
\}
" TODO: Needs a way to specify which python version (3) to use

" let test#python#runner = 'python3 pytest'
" }}}
