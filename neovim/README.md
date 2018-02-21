meVim
=====

*My personal configurations for NeoVim, which by contrast to my vanilla vim config is a fully featured IDE for Python, Javascript, C++, Platform IO, Shell, Rust & Go*


Overall Design of NeoVim Configs
--------------------------------

* This [guy](https://github.com/tjdevries/config_manager/blob/master/nvim/init/02-plugins.vim) has some pretty neat ideas about how to manage vim dotfiles.

Keymaps
-------

* Leader: (`,` key)
  * `<leader>l`: Toggle `vim-javascript` concealing features
  * `<leader>f`: Bring up fzf file search with command `Files`
  * `<leader>h`: Disable highlights
* Control `^SOMEKEY`
  * `^j`: during insert will expand ultisnips if detected by deoplete & will jump through snippet insertions when repeated
* Pane Controls


Folding
-------

- Here's a good place to go over how to change settings based on filetype
  - This snippet sets `foldmethod=marker` based on filetypes
  - `autocmd BufRead,BufNewFile   *.c,*.h,*.java set noic cin noexpandtab`




Markdown Editing
----------------

### Vim-Pandoc ###
- Some great settings are detailed in this [reddit thread][17]
* this plugin automatically has spell check concealing on, disable it on startup by putting this in the plugins config file `set nospell`
* Turn it back on again by going to *command mode* & entering `set spell`

### Vim Markdown Composer ###
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

There are various configurations that are unfortunately only written down into the help file, which is accessible from the vim command, `help markdown-composer`. The default local route is `localhost`, **but** unfortunately, it uses a random open port every time it starts, so it is often better to just use the commands: `ComposerOpen` to open the default browser, and then `ComposerStart` to start the composer.

#### Markdown Composer Options ####

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

### `Vim-Javascript` ###

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


### TernJS ###


File Management
---------------

### fzf, fd, & rg ###
- FZF has a vim plugin [`junnegun/fzf.vim`][13]
- Provides  hooks into the `FZF_DEFAULT_COMMAND` defined in shell vars
- Can be used to search files, Git, Buffers, color schemes, ag, tags, history, keymaps, etc.

#### Commands ###


| Command           | List                                  |
| ---               | ---                                   |
| `Files [PATH]`    | Files (similar to `:FZF`)             |
| `GFiles [OPTS]`   | Git files (`git ls-files`)            |
| `GFiles?`         | Git files (`git status`)              |
| `Buffers`         | Open buffers                          |
| `Colors`          | Color schemes                         |
| `Ag [PATTERN]`    | [ag][ag] search (`ALT-A` select all `ALT-D` deselect all) |
| `Lines [QUERY]`   | Lines in loaded buffers               |
| `BLines [QUERY]`  | Lines in the current buffer           |
| `Tags [QUERY]`    | Tags in the project (`ctags -R`)      |
| `BTags [QUERY]`   | Tags in the current buffer            |
| `Marks`           | Marks                                 |
| `Windows`         | Windows                               |
| `Locate PATTERN`  | `locate` command output               |
| `History`         | `v:oldfiles` and open buffers         |
| `History:`        | Command history                       |
| `History/`        | Search history                        |
| `Snippets`        | Snippets ([UltiSnips][us])            |
| `Commits`         | Git commits (uses [fugitive.vim][f])  |
| `BCommits`        | Git commits for the current buffer    |
| `Commands`        | Commands                              |
| `Maps`            | Normal mode mappings                  |
| `Helptags`        | Help tags <sup id="a1">[1](#helptags)</sup> |
| `Filetypes`       | File types                            |


Completion
----------

* This guy wrote a decent enough [guide][18] this when combining `ultisnips`, `deoplete`, `ternjs` & `jspc`
  * It misses a crucial setting, `let g:deoplete#sources.javascript = ['buffer', 'tern']`
  * crucial because the way he writes it is `...#sources['javascript']...` which fails
* Uses [carlitux/deoplete-ternjs][19] to manage displaying completions from tern
* `sudo npm i -g tern` is required to install on local system
* `tern` will also need to be configured with a `.tern-project` specific to the project or local userspace
  * The Tern [documentation][21] is a good pace to start
* if the plugin system doesn't automatically handle the installation of node packs for the plugins make sure deoplete-tern has its plug dir run it
  * same for [tern_for_vim][20]
* `tern_for_vim` & `deoplete-ternjs` needs some improvements like...
  * Not reversing the order of `<Tab>` during completion selection
  * showing function signatures in popup menu, refered to as `pum`
  * `TernDef`
  * `TernDoc`
  * `TernType`
  * `TernRefs`
  * `TernRename`



Snippets
--------

* The current snippet engine being used is defined by `let g:my_snippet_manager`
	- Valid options are: (`ultisnips`, `neosnippet`)
* Snippets are stored in `$HOME/dotfiles/neovim/UltiSnips`
* To deal with conflicting pop up menu access between `UltiSnips` & `Deoplete`, use this config snippet, currently housed in the plugins configurations 
* They are accessible from `deoplete` by tabbing and then selecting the completion with `Ctrl+j` & continuing to hit that key combo to go through each insertion point of the snippet




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
	* [x] `noh` binding, using leader key
	* [ ] Snippets [`Github: SirVer/ultisnips`][14]
	* [ ] Better folding techniques
	  * A good [guide][12]
	* [ ] Class & Function Tags
	* [ ] mvim
	* [ ] Update Scripts
	* [ ] Bash Aliases "mevim"
	* [ ] Improve portability with xdg & dynamic filepaths: [link][100]
	* [ ] indentation grids
	* [ ] Basic neovim terminal keymaps, like [this][11] maybe?
	  * just use a light `|` character
* FuzzyFinder with Keymaps
  * [x] fuzzy finder
	  * `fzf.vim` installed
	  * `<leader>+f` opens `Files:` command to search for files
  * [ ] fzf & ripgrep function to search notes directory & open the selected file
* Markdown
	* [x] `noh` binding, using leader key
	* [x] External Renderer
		* Handled by `vim-markdown-composer`
	* [x] Pandoc Integration
		* handled by `vim-pandoc`
		* [ ] update `init.vim` to only load by filetype
	* [ ] External pandoc hooks
	* [ ] table formatting
	* [ ] Distraction free mode [goyo][15]
	* [ ] Concealer options
	* [ ] Settings from this [article](https://hackernoon.com/vim-for-writers-ee15d2a8f512)
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
		* Perhaps `vimwiki`
		* concealer syntaxes for markdown
	* [ ] Prose focused writing mode, *(think iA writer)*
	* [ ] Dictionary & Thesaurus features
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
	* [ ] Nice low contrast theme with bells & whistles [`seoul256`][16]
	* [ ] Gruvbox theme
	* [ ] `ayu.vim`
	* [ ] General concealers
		  * [ ] const/var/let

References
----------

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
13. [Github: junegunn/fzf.vim][13]
14. [Github: SirVer/ultisnips][14]
15. [Github: junnegun/goyo.vim - Distraction-Free Writting][15]
16. [Github: junnegun/seoul256][16]
17. [r/vim: Great Notetaking Configs][17]
18. [Flawed but useful overview on deoplete with snips, & tern][18]
19. [Github: carlitux/deoplete-ternjs][19]
20. [Github: ternjs/tern_for_vim][20]
21. [TernJS: Reference Manual - Needed to configure local TernJs][21]


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
[13]: https://github.com/junegunn/fzf.vim "Github: junegunn/fzf.vim"
[14]: https://github.com/SirVer/ultisnips "Github: SirVer/ultisnips"
[15]: https://github.com/junegunn/goyo.vim "Github: junnegun/goyo.vim - Distraction-Free Writting"
[16]: https://github.com/junegunn/seoul256.vim "Github: junnegun/seoul256"
[17]: https://www.reddit.com/r/vim/comments/2r24nm/note_taking_using_vim_and_pandocs/ "r/vim: Great Notetaking Configs"
[18]: https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/ "Flawed but useful overview on deoplete with snips, & tern"
[19]: https://github.com/carlitux/deoplete-ternjs "Github: carlitux/deoplete-ternjs"
[20]: https://github.com/ternjs/tern_for_vim "Github: ternjs/tern_for_vim"
[21]: http://ternjs.net/doc/manual.html "TernJS: Reference Manual - Needed to configure local TernJs"

[100]: http://bit.ly/2y0UkPU
