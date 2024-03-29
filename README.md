# dotfiles

A collection of my dotfiles. 

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Configs](#configs)
    * [bash](#configs-bash)
        * [Prompt](#configs-bash-prompt)
        * [Aliases](#configs-bash-aliases)
        * [Functions](#configs-bash-functions)
    * [conky](#configs-conky)
    * [tmux](#configs-tmux)
        * [Custom key bindings](#configs-tmux-bindings)
    * [vim](#configs-vim)
        * [Custom key bindings](#configs-vim-bindings)

<h2 id="installation">Installation</h2>

Clone the repo into a directory of your choice. Home is recommended to keep things neat but any directory will work.

    cd ~
    git clone https://github.com/bananana/dotifles

Optionally, hide the dotfiles directory.

    mv dotfiles/ .dotfiles/ 

<h2 id="usage">Usage</h2>

```
     _       _    __ _ _
  __| | ___ | |_ / _(_| | ___ _ __
 / _` |/ _ \| __| |_| | |/ _ | '__|
| (_| | (_) | |_|  _| | |  __| |
 \__,_|\___/ \__|_| |_|_|\___|_|
```

`./dotfiler.sh` is a script to manage dotfiles from a central directory. The dotfiles directory should have subdirectories, corresponding to various programs, containing their respective config files (dotfiles). The script creates symlinks from these dotfiles to your home directory. 
You can store the entire dotfiles directory on a VCS or the cloud and deploy it on any machine by simply cloning or copying it. 

Run `./dotfiler.sh -h` for full documentation. Below is a summary of it's functionality.

| Options    | Description |
|------------|-------------|
|`-h, --help`|Display help |
|`-l, --list`|List all available config directories |
|`-L, --list-long`|List all available config directories, including their contents |
|`-u, --update`|Perform git pull, update and init any git submodules |
|`-s, --symlink <dir>`|Create symlinks in home directory for files found in `<dir>` |
|`-r, --remove-symlinks <dir>`|Remove symlinks for files found in `<dir>` from home directory |
|`-x, --exclude <dir>`|Exclude `<dir>` from git index and remove it from dotfiles directory |
|`-i, --include <dir>`|Reverse `--exclude` by removing `<dir>` from `.git/info/exlclude` and checking it out from the repo |
|`-d, ----list-excluded`|List config directories exluded with --exclude |

E.g. symlink dotfiles located in "bash" directory into home directory:

	./dotfiler.sh -s bash

**Note:** If you're going to use the vim config, then you have to initialize the various bundles, which are stored as git submodules:

	./dotfiler.sh -u

Which is equivelent to:

    git pull; git submodule update --init

<h2 id="configs">Configs</h2>

<h3 id="configs-bash">bash</h3>

Bash config including a custom PS1 prompt a few aliases and functions. Functions, aliases, prompt and logout are broken out into separate files. 

<h4 id="configs-bash-prompt">Prompt</h4>

Two line smart prompt. Features:

* Adds a notice if using python virtualenv.
* Hightlights root user in red. 
    - **Caveat:** the root user needs to source this config. The easiest way to do that is to switch to root user with `su -p`, which preserves the normal user environment (i.e. it does not set $HOME, $SHELL, $USER and $LOGNAME).
* Hightlights hostname in red if logged in through ssh. 
    - **Caveat**: You'll need to source this bash config on remote host either by cloning this repo into it or manually uploading the files. You can also theoretically pass the $PS1 environment variable to remote host with ssh `-t` option, but this feature is often disabled in server configuration by default.

Preview:

    ┌─[username@hostname]─[cwd]
    └──╼

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

<h4 id="configs-bash-functions">Functions</h4>

|Function   |Usage                                             |Description                                      |
|-----------|--------------------------------------------------|-------------------------------------------------|
|`cd_func`  |`cd --`                                           |Show your cd history                             |
|`testport` |`testport <servername \|\| ip> <port> <protocol>` |Quickly check if a port is open                  |
|`listening`|`listening <port>`                                |Find out which processes are listening on a port |
|`unpack`   |`unpack <compressed_file>`                        |Uncompress a compressed file                     |

---

<h3 id="configs-conky">conky</h3>

Conky config inspired by original crunchbang.

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
|`<prefix> + (H\|\L)`             |Swap panes                                             |
|`<copy_mode> v`                  |Vim-like select in copy mode                           |
|`<copy_mode> y`                  |Vim-like yank in copy mode                             |
|`<prefix> + b`                   |Toggle status line                                     |

---

<h3 id="configs-vim">vim</h3>

My vim config. Included are [emmet-vim](https://github.com/mattn/emmet-vim), [lightline](https://github.com/itchyny/lightline.vim), [nerdtree](https://github.com/scrooloose/nerdtree) plugins and [lucius](https://github.com/jonathanfilip/vim-lucius) theme. 

<h4 id="configs-vim-bindings">Custom key bindings</h4> 

|Command                |Description                                       |
|-----------------------|--------------------------------------------------|
|`Ctrl + (h\|j\|k\|l)`  |Move between panes in given direction             |
|`Shift + (h\|j\|k\|l)` |Resizes panes in given direction                  | 
|`Ctrl + n`             |Toggles nerdtree                                  |
|`F4`                   |Toggle Colorizer. Equivalent to `:ColorToggle`    |
|`F5`                   |Toggles paste mode                                |
|`Space`                |Removes search highlighting. Equivalent to `:noh` |
