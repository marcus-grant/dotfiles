All My Common Dotfiles
======================

### NOTE

This is my archive of my old dotfiles repository which is now split into a repo for each dotfile set with the prefix in the repo name dots-NAMEOFDOTFILE so for neovim it's dots-neovim. They're all now managed using ansible and I have my own [role](https://github.com/marcus-grant/role-dotfiles) in ansible that manages all of them, or soon will manage all of them. This is perhaps a decent example of how to manage your dotfiles through more traditional means so by all means take a look or clone if you're so inclined.

All of my dotfiles that are shared between all my systems. For the more complicated dotfiles, they are most likely in their own repo and are represented here by git submodules leading to their respective repositories. For the numerous smaller sets of dotfiles, they are managed here directly because it seems excessive to give repositories to all the dotfiles that are needed.

Some of the intermediary inspiration was taken from [tjdevries/config_manager](https://github.com/tjdevries/config_manager)

Neovim: Isolated Pyenv Procedure
--------------------------------

* Install build dependencies for pyenv:
    * ubuntu/debian: `sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev`
    * Fedora/CentOS/RHEL:
        `sudo dnf install zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel`
    * Mac:
        * `brew install readline xz`
    * Arch: **look up instructions there's probably either a pac or aur package for it**
* Run these commands **SKIP THE EXPORTS PARTS THSES HAVE ALREADY BEEN ADDED:***
```sh
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
#echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
#echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
exec "$SHELL"
pyenv install 3.4.4
pyenv virtualenv 3.4.4 neovim3
pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH
```
* Already done, but for notes, add this to `init.vim`: `let g:python3_host_prog = '/full/path/to/neovim3/bin/python'`
* **NOTE** [these instructions][03] might help more, they also have more environments with instructions for install.

To-Dos
------

* [ ] Migrate old dotfiles as submodules
  * [ ] bash
  * [ ] neovim
  * [ ] tmux-conf
  * [ ] termite
  * [ ] i3
  * [ ] polybar
  * [ ] sysadmin-scripts
* Migrate by copying
  * On jord
    * [ ] fzf
    * [ ] alacritty
* [ ] Create `update-env` scripts
  * [ ] Main
    - The main script that goes through all level-1 subdirectories and calls `update-env`
    - Updates all submodules
  * [ ] bash
  * [ ] neovim
  * [ ] tmux-conf
  * [ ] termite
  * [ ] i3
  * [ ] polybar
  * [ ] sysadmin-scripts

References
----------

1. [github: pyenv/pyenv (instructions)][01]
2. [github: zchee/deoplete-jedi (instructions)][02]
3. [PyGObject: Creating a Python Development Environment][03]

[01]: https://github.com/pyenv/pyenv#installation "github: pyenv/pyenv (instructions)"
[02]: https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim "github: zchee/deoplete-jedi (instructions)"
[03]: http://pygobject.readthedocs.io/en/latest/devguide/dev_environ.html "PyGObject: Creating a Python Development Environment"
