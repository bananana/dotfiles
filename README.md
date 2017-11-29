# dotfiles

A collection of my dotfiles. 

## Installation

Clone the repo and setup the dotfiles directory: 

    cd
    git clone https://github.com/bananana/dotifles
    mv dotfiles/ .dotfiles/
    cd .dotfiles

To manage the dotfiles use the builtin `dotfiler.sh` script:
```
		 _       _    __ _ _
	  __| | ___ | |_ / _(_| | ___ _ __
	 / _` |/ _ \| __| |_| | |/ _ | '__|
	| (_| | (_) | |_|  _| | |  __| |
	 \__,_|\___/ \__|_| |_|_|\___|_|

		Synopsis:

			.dotfiler.sh is a script used to manage dotfiles from a central location. The dotfiles directory
			should have subdirectories, corresponding to various applications, containing their respective
			config files (dotfiles). The script creates symlinks from these dotfiles to your home directory.
			You can then store the entire dotfiles directory on a VCS or the cloud and deploy it on any
			machine by simply cloning or copying it and this script.

		Usage:

			.dotfiler.sh [ options ] package

		Options:

			-h  Display this help message

			-l  List all available packages

			-L  List all available packages, including their contents

			-s package, -c package
				Create symlinks in /home/pavel for files found in package directory

			-d package
				Delete symlinks for given package from /home/pavel

			-u package
				Update symlinks for given package

		Examples:

			.dotfiler.sh -s vim
				Symlink dotfiles located in vim directory into /home/<username>
```

If you're going to use the vim config, then you have to initialize the various bundles:

    git submodule update --init

## Contents

### bash

A fairly standard bash config, includes a custom PS1 prompt and a few aliases. Functions, aliases and logout are broken out into separate files. Aliases included:

|Command |Alias                 |
|--------|----------------------|
|`ls`    |`ls --color=auto`     |
|`dir`   |`dir --color=auto`    |
|`vdir`  |`vdir --color=auto`   |
|`grep`  |`grep --color=auto`   |
|`fgrep` |`fgrep --color=auto`  |
|`egrep` |`egrep --color=auto`  |
|`ll`    |`ls -alFh`            |
|`la`    |`ls -Ah`              |
|`l`     |`ls -CFh`             |
|`..`    |`cd ..`               |
|`...`   |`cd ../..`            |
|`....`  |`cd ../../..`         |
|`.....` |`cd ../../../..`      |

`alert` alias is an easy way to call `notify-send` for long running commands. It will show the command in your notifications when it completes. For example:

	sleep 5; alert 

Helpful bash functions:

|Command            |Description                                                |
|-------------------|-----------------------------------------------------------|
|`cd --`            |Show your cd history                                       |
|`python_virtualenv`|Helper function for generating PS1 prompt.                 |

### conky

Conky config inspired by original crunchbang.

### mintty

If on Windows and using Cygwin this configures the mintty terminal to match the overall colorscheme and style.

### tmux

A basic tmux config with some vim-like custom key assignments. The status line is off by default.

Custom key bindings:

|Command               |Description |
|----------------------|------------|
|`Alt + a`             |<prefix>    |
|`<prefix> + \`        |Horizontal split|
|`<prefix> + |` 	   |Vertical split|
|`<prefix> + h|j|k|l`  |Switches focus between the splits in given direction|
|`<prefix> + Ctrl + h|j|k|l`|Resizes the currently active split in givend direction|

### vim

My vim config. Included are [emmet-vim](https://github.com/mattn/emmet-vim), [lightline](https://github.com/itchyny/lightline.vim), [nerdtree](https://github.com/scrooloose/nerdtree) plugins and [lucius](https://github.com/jonathanfilip/vim-lucius) theme. 

There are also several custom shortuct keys: 
|Command             |Description |
|--------------------|------------|
|`Ctrl + (h|j|k|l)`  |Move between panes|
|`Shift + (h|j|k|l)` |Resizes panes| 
|`Ctrl + n`          |Toggles nerdtree|
