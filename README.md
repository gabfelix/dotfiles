# dotfiles
These are my personal configuration files and scripts managed using GNU Stow.

## Structure
The system is divided into modules, represented by the top-level directories.
The structure inside each module mimicks the target structure in the `$HOME`
directory. This is why pretty much every folder has a `.config` inside it.

I tried to make it as modular as I could, but there is some connection between
different programs. For example, the reason why I can put my scripts in
`~/.local/bin` is because I add it to my `$PATH` in my bashrc, so every
directory with `.local/bin` has an implicit dependency on the "bash" directory.

Since these are my personal configurations and this is (at the time of writing)
a private repository, I won't make any effort to document such dependencies.
Should this repository become public, any potential users of these files are
expected to fix the issues themselves and (if possible) contribute a fix back.

## Installation
Create symlinks to everything in `~` using GNU Stow:
```sh
$ stow */ -t ~/
```

You may also pick and choose specific programs to link:
```sh
$ stow bash sway -t ~/
```
