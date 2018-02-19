meVim
=====

*My personal configurations for NeoVim, which by contrast to my vanilla vim config is a fully featured IDE for Python, Javascript, C++, Platform IO, Shell, Rust & Go*

Keymaps
-------

* Leader: `,`
  * `<leader>l`: Toggle `vim-javascript` concealing features
* Pane Controls


Folding
-------

- Here's a good place to go over how to change settings based on filetype
  - This snippet sets `foldmethod=marker` based on filetypes
  - `autocmd BufRead,BufNewFile   *.c,*.h,*.java set noic cin noexpandtab`




Markdown Editing
----------------
### Vim Markdown Composer
A plugin that uses the Rust framework **Aurelius** to live-render markdown into a local server. It requires rust install, which can be done by entering this command into the command line, `curl https://sh.rustup.rs -sSf | sh`. Then it's installed into this configuration by entering into the `init.vim` file, this snippet of code below.
```viml
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
```

There are various configurations that are unfortunately only written down into the help file, which is accessible from the vim command, `help markdown-composer`. The default local route to this page is [`http://[::1]:40447/`](http://[::1]:40447/)

#### Markdown Composer Options
* `g:markdown_composer_browser`: Specifies a browser for the plugin to use, if not specified, it will use the default.
* `g:markdown_composer_open_browser`: If set to `0`, then the plugin won't attempt to open the user's specified browser, requiring the user to open it to the local address manually
* `g:markdown_composer_external_renderer`: This allows an external command to be run by the server to render.
  * It does so by sending out text through **stdout** into the command, then back using **stdin**
  * Since doing this externally is slower than with the regular renderer, refresh rates might need to be altered
  * Ex: `let g:markdown_composer_external_renderer='pandoc -f markdown -t html'`
    * This uses the infamous `pandoc` to handle external rendering
* `g:markdown_composer_refresh_rate`: The rate in ms that new markdown should be sent from the buffer to the server, defaults *(0)* to every keystroke
* `g:markdown_composer_syntax_theme`: The theme that gets used to render code blocks with syntax highlighting
  * More info [here](https://highlightjs.org/static/demo/)
  * Variable should be set by the CSS file's path minus the `*.css` extension
  * The default is Github's style
* `g:markdown_composer_autostart`: Whether the server should start automatically whenever a markdown buffer is opened
  * Defaults to `1`, ie yes
* `g:markdown_composer_custom_css`: A list of custom CSS URIs that should be loaded instead of the Github Styles
  * Can be local paths and URLs
  * **NOTE** they **must** use absolute and prefixed schemes like so: `file:///home/euclio/markdown.css`

Javascript
----------
### `Vim-Javascript`
* There are **concealing** features embedded that can make code look nice, but crucially make code shorter when editing in neovim
* Below is an example config that is currently placed in `plugins.vim`

```viml
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
```
* On top of setting concealing characters, it turns concealing on with `set conceallevel=1`
* Then there's a keymap that toggles JS concealment `<leader>l`


### TernJS

 


To-Do's
-------
* Miscellaneous
  * [x] Install Script
  * [x] Plugin Manager
  * [x] Tmux integration
  * [x] NERDTree
  * [x] Pane Management w/ Keymaps
  * [x] Sufficient Defaults
  * [x] `foldmethod=marker` for vim & sh
  * [ ] Better folding techniques
    * A good [guide][12]
  * [ ] noh binding, using leader key and/or defaults for substitutions to disable this
  * [ ] Class & Function Tags
  * [ ] Copy Over Keymaps, and File Recognizers from Vim
  * [ ] Previous Vim settings
  * [ ] Git editing ? *maybe better for lvim*
  * [ ] mvim
  * [ ] Update Scripts
  * [ ] Bash Aliases "mevim"
  * [ ] Improve portability with xdg & dynamic filepaths: [link][100]
* FuzzyFinder with Keymaps
  * [ ] fuzzy finder
  * [ ] indentation grids
  * [ ] Basic neovim terminal keymaps, like [this][11] maybe?
    * just use a light `|` character
  * [ ] Insert/Remove newlines from outside editor
* Javascript
  * [x] Proper Syntax & Spacing
    * handled by `vim-jsx` & `vim-javascript`
  * [x] JSX recognition
  * [ ] Folding 
  * [ ] ternjs with deoplete
  * [ ] graphQL highlighting
  * [ ] Snippets
  * [ ] JSDocs
    * [ ] `vim-jsdoc`
  * [ ] Function parameter completion
    * [ ] `jspc.vim`?
  * [ ] CTags support
    * consider `ramitos/jsctags`
  * [ ] EditorConfigs
  * [ ] Emmet configs for JSX
  * [ ] Local & Import Autocomplete
* HTML & CSS
  * [ ] Emmet & Keymaps
  * [ ] Tag Surrounds
  * [ ] File & Local Autocomplete
  * [ ] RGB highlighting
* Markdown
  * [x] External Renderer
    * Handled by `vim-markdown-composer`
  * [ ] Pandoc Integration
  * [ ] Concealer options
  * [ ] Auto fold h2 & lower
  * [ ] Block Editing
  * [ ] Highlighting
  * [ ] Linting Grammar & Spelling *(write-good?)*
  * [ ] Latex Blocks
  * [ ] Ctags integration?
  * [ ] Automatic references link or bibilography
  * [ ] Better moving through large blocks of text
    * Perhaps using hard/soft wraps?
    * Perhaps using block focusing, where only one block is seen by choice
    * Should have some keymaps to better move through a block
  * [ ] Some kind of *org-mode*-like features
    * Perhaps `vim-wiki`
    * concealer syntaxes for markdown
  * [ ] Prose focused writing mode, *(think iA writer)*
  * [ ] Dictionary & Thesaurus features
* Go
  * [ ] Linting
  * [ ] Autocompletion
  * [ ] Basic doctype plugin
  * [ ] Style & config defaults, use [this][09] as a guide
  * [ ] NeoSnippet
  * [ ] `delve` for debugging
* Python
  * [ ] Linting
  * [ ] External Running
  * [ ] Beautify
  * [ ] Autocomplete
  * [ ] Horiz Ruler
* Appearance
  * [x] fix `PaperColor` highlighting for conceals
    * handled by chancing `Conceal` option in `colors/PaperColor.vim`
  * [ ] `ayu.vim`
  * [ ] General concealers
    * [ ] const/var/let

## References
1. [Github/rafi/vim-config: A good example of a config][01]
2. [vi.stackexchange: Windows Neovim Setup (config location hierarchy)][02]
3. [CoderOnCode: Vim is the Perfect IDE][03]
4. [r/neovim: neovim JSX Suggestions][04]
5. [Thoughtbot: tmux Copy & Paste on OS X: A Better Future][05]
6. [Medium(Victor Mourns): A better NERDTree Setup][06]
7. [Thoughtbot: Vim Splits - Move Faster & More Naturally][07]
8. [Github: euclio/vim-markdown-composer][08]
9. [Hackernoon: Go & NeoVim][09]
10. [Github: calitux/deoplete-ternjs][10]
11. [Jacques Visser (Medium): Neovim Has a Built-In Terminal Emulator?!][11]
12. [Steve Losh - Advanced Folding][12]


[01]: https://github.com/rafi/vim-config "Github/rafi/vim-config: A good example of a config"
[02]: https://vi.stackexchange.com/questions/12579/windows-neovim-setup "vi.stackexchange: Windows Neovim Setup (Used for config location hierarchy)"
[03]: http://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html "CoderOnCode: Vim is the Perfect IDE"
[04]: https://www.reddit.com/r/neovim/comments/4jxx4d/neomake_and_jsx/?st=j7wwkj76&sh=22574b55 "r/neovim: neovim JSX Suggestions"
[05]: https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future "Thoughtbot: tmux Copy & Paste on OS X: A Better Future"
[06]: https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9 "Medium(Victor Mourns): A better NERDTree Setup"
[07]: https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally "Thoughtbot: Vim Splits - Move Faster & More Naturally"
[08]: https://github.com/euclio/vim-markdown-composer "Github: euclio/vim-markdown-composer"
[09]: https://hackernoon.com/my-neovim-setup-for-go-7f7b6e805876 "Hackernoon: Go & NeoVim"
[10]: https://github.com/carlitux/deoplete-ternjs "Github: calitux/deoplete-ternjs"
[11]: https://medium.com/@jcqvisser/neovim-has-a-built-in-terminal-emulator-cf057f767dbc "Jacques Visser (Medium): Neovim Has a Built-In Terminal Emulator?!"
[12]: http://learnvimscriptthehardway.stevelosh.com/chapters/49.html "Steve Losh - Advanced Folding"

[100]: http://bit.ly/2y0UkPU
