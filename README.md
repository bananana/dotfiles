# dotfiles

A collection of my dotfiles. 

## Table of Contents

* [Installation](#installation)
* [Configs](#configs)
    * [bash](#configs-bash)
        * [Aliases](#configs-bash-aliases)
        * [Functions](#configs-bash-functions)
    * [conky](#configs-conky)
    * [mintty](#configs-mintty)
    * [tmux](#configs-tmux)
        *[Custom key bindings](#configs-tmux-bindings)
    * [vim](#configs-vim)
        *[Custom key bindings](#configs-vim-bindings)

<h2 id="installation">Installation</h2>

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

	-p  Pull git submodules. Equivalent to `git submodule update --init`  

	-s package, -c package
		Create symlinks in $HOME for files found in package directory

	-d package
		Delete symlinks for given package from $HOME 

	-u package
		Update symlinks for given package

Examples:

	./dotfiler.sh -s bash
		Symlink dotfiles located in vim directory into $HOME
```

If you're going to use the vim config, then you have to initialize the various bundles, which are stored as git submodules:

	./dotfiler.sh -p

Which is equivelent to:

    git submodule update --init

<h2 id="configs">Configs</h2>

<h3 id="configs-bash">bash</h3>

Bash config including a custom PS1 prompt a few aliases and functions. Functions, aliases, prompt and logout are broken out into separate files. 

<h4 id="configs-bash-aliases">Aliases</h4>

|Command  |Alias                 |
|---------|----------------------|
|`ls`     |`ls --color=auto`     |
|`dir`    |`dir --color=auto`    |
|`vdir`   |`vdir --color=auto`   |
|`grep`   |`grep --color=auto`   |
|`fgrep`  |`fgrep --color=auto`  |
|`egrep`  |`egrep --color=auto`  |
|`ll`     |`ls -alFh`            |
|`la`     |`ls -Ah`              |
|`l`      |`ls -CFh`             |
|`..`     |`cd ..`               |
|`...`    |`cd ../..`            |
|`....`   |`cd ../../..`         |
|`.....`  |`cd ../../../..`      |
|`ports`  |`netstat -tulanp`     |
|`headers`|`curl -I`             |

`alert` alias is an easy way to call `notify-send` for long running commands. It will show the command in your notifications when it completes. For example:

	sleep 5; alert 

<h4 id="configs-bash-functions">Functions</h4>

|Function   |Usage                                             |Description                     |
|-----------|--------------------------------------------------|--------------------------------|
|`cd_func`  |`cd --`                                           |Show your cd history            |
|`testport` |`testPort <servername \|\| ip> <port> <protocol>` |Quickly check if a port is open |
|`unpack`   |`unpack <compressed_file>`                        |Uncompress a compressed file    |

---

<h3 id="configs-conky">conky</h3>

Conky config inspired by original crunchbang.

---

<h3 id="configs-mintty">mintty</h3>

If on Windows and using Cygwin this configures the mintty terminal to match the overall colorscheme and style.

---

<h3 id="configs-tmux">tmux</h3>

A basic tmux config with some vim-like custom key assignments. The status line is off by default.

<h4 id="configs-tmux-bindings">Custom key bindings</h4>

|Command                          |Description                                            |
|---------------------------------|-------------------------------------------------------|
|`Alt + a`                        |`<prefix>` (replaces default, which is `Ctrl + b`)     |
|`<prefix> + \`                   |Horizontal split                                       |
|`<prefix> + \|` 	              |Vertical split                                         |
|`<prefix> + (h\|j\|k\|l)`        |Switches focus between the splits in given direction   |
|`<prefix> + Ctrl + (h\|j\|k\|l)` |Resizes the currently active split in givend direction |

---

<h3 id="configs-vim">vim</h3>

My vim config. Included are [emmet-vim](https://github.com/mattn/emmet-vim), [lightline](https://github.com/itchyny/lightline.vim), [nerdtree](https://github.com/scrooloose/nerdtree) plugins and [lucius](https://github.com/jonathanfilip/vim-lucius) theme. 

<h4 id="configs-vim-bindings">Custom key bindings</h4> 

|Command                |Description                           |
|-----------------------|--------------------------------------|
|`Ctrl + (h\|j\|k\|l)`  |Move between panes in given direction |
|`Shift + (h\|j\|k\|l)` |Resizes panes in given direction      | 
|`Ctrl + n`             |Toggles nerdtree                      |
|`F5`                   |Toggles paste mode                    |
