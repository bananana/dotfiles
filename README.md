# dotfiles

A collection of my dotfiles. 

## Installation

Clone the repo and setup the config directory: 
```
cd
git clone https://github.com/bananana/dotifles
mv dotfiles/ .dotfiles/
cd .dotfiles
```

If you're going to use the vim config, then you have to initialize the various bundles:
```
git submodule update --init
```

To update the bundled plugins after installation, run this:
```
git submodule foreach git pull orignin master
```

Use [GNU Stow](https://packages.debian.org/jessie/stow) to access the files more efficienly. From the *dotfiles* directory run the `stow` command with the config you want applied:
```
cd .dotfiles
stow vim
```

## Contents

### bash

A fairly standard bash config, includes a custom PS1 prompt and a few aliases. Functions, aliases and logout are broken out into separate files. 

### bash-eOS

Slightly different bash config that includes customizations for pantheon-terminal (a terminal for Elementary OS).

### conky-crunchbang

Conky config inspired by original crunchbang.

### tmux

A basic tmux config with some custom key assignments. Alt+a is now the prefix, Prefix+\ is horizontal split, Prefix+| is vertical split.

### vim

My vim config. Comes with emmet and nerdtree plugins. Vim airline plugin is there but I'm still tweaking it, so it's disabled. There are also several custom shortuct keys: Ctrl+(h|j|k|l) now moves between panes, Shift+(h|j|k|l) resizes panes, Ctrl+n toggles nerdtree.
