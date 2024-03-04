# dotfiles
These are my personal configuration files and scripts managed using GNU Stow.

## Structure
The system is divided into modules, represented by the top-level directories. The structure inside each module mimicks the target structure in the `$HOME` directory. This is why pretty much every folder has a `.config` inside it.

I tried to make it as modular as I could, but there is some connection between different programs. For example, the reason why I can put my scripts in `~/.local/bin` is because I add it to my `$PATH` in my bashrc, so every directory with `.local/bin` has an implicit dependency on the "bash" directory.

Since these are my personal configurations and this is (at the time of writing) a private repository, I won't make any effort to document such dependencies. Should this repository become public, any potential users of these files are expected to fix the issues themselves and (if possible) contribute a fix back.

## Installation
### GNU Stow
Assuming you've already cloned and entered this repository, run this to create symlinks to all directories in ~/ using GNU Stow:
```sh
$ stow */ -t ~
```

You may also pick and choose specific programs to link:
```sh
$ stow bash sway -t ~
```

To avoid folding (symlinking the entire directory instead of only the files) and getting logs and other junk files inside this repo, consider using the `--no-folding` flag: 
```sh
$ stow --no-folding bash sway -t ~
```
Note that this makes it harder to check new files into the repository, as you'll have to manually copy them over.

You can remove any symlinks previously added by giving stow the `-D` flag. For example, you could use this series of commands to switch from bash to zsh:
```sh
$ stow -D bash -t ~
$ stow --no-folding zsh -t ~
```

### Wrapper script
The `stowit.sh` wrapper script can help the user quickly stow to `$HOME` by wrapping around the stow command. Assuming you're inside this repository's cloned directory, run:
```sh
$ ./stowit.sh */
```

You may also pass specific modules, just like before:
```sh
$ ./stowit.sh bash sway
```
