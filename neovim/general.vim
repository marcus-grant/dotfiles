" general.vim
" Segmented vim config file for all general configurations.
" Used for global settings, and miscelaneous ones that don't fit elsewhere.

set showcmd		" show partial commands in statusline
set showmatch		" show matching brackets
set showmode		" show current mode
set ruler		" show ruler
"set number		" show line numbers

" considered superior to smartindent: http://bit.ly/2y03n3x
filetype plugin on
filetype plugin indent on
"set smartindent     " chose which setting based off file
set expandtab		" insert spaces when TAB is pressed
" Set default tab behaviors and then specific filetypes with 2 spaces
set tabstop=4		" default spaces used for tabs as 4
set shiftwidth=4	" indentation increments when using '<' & '>'
au FileType javascript setlocal tabstop=2 shiftwidth=2
au FileType html setlocal tabstop=2 shiftwidth=2
" Go specific ( might not be needed as go uses 4:4 format )
au FileType go set softtabstop=4

" TODO figure out which settings need to be changed by OS, by default use unix
" host OS settings
" set ff="unix"
" if has("unix")
"   let s:uname = system("uname")
"   if s:uname == "Darwin\n"
"     " Do Mac stuff here
"   endif
" endif

set noerrorbells	" no beeps please
set modeline		" enable modeline
"set nojoinspaces	" prevents insertion of two spaces after punctiation on join (J)

" More natural splitting behaviors
set splitbelow
set splitright

" Better search defaults
set ignorecase		" make searching case-INSENSITIVE
set smartcase		" ...UNLESS the query has capital letters within it
set gdefault		" use 'g' flag by default with :s/foo/bar/
set magic		" use 'magic' patterns (regex extensions)

" fold settings{{{
" set default fold level to unfolded
set foldlevel=99

" specify foldmethod by filetype
autocmd BufRead,BufNewFile   *.sh,*.vim set foldmethod=marker
"}}}

" FZF - Jump to Tags
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

" FZF with RIPGREP, from http://bit.ly/2pJv5M3
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
