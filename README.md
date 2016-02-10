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

A fairly standard bash config, includes a custom PS1 prompt and a few aliases.

### bash_alt

Slightly differnt bash config that includes customizations for pantheon-terminal (a terminal for Elementary OS).

### conky

Conky config inspired by original crunchbang 

### tmux

A basic tmux config with some custom key assignments

### vim

My vim config.
