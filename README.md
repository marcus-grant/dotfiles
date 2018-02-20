All My Common Dotfiles
======================

All of my dotfiles that are shared between all my systems. For the more complicated dotfiles, they are most likely in their own repo and are represented here by git submodules leading to their respective repositories. For the numerous smaller sets of dotfiles, they are managed here directly because it seems excessive to give repositories to all the dotfiles that are needed.

Some of the intermediary inspiration was taken from [tjdevries/config_manager](https://github.com/tjdevries/config_manager)

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
