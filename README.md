# Dotfiles
These are my personal dotfiles managed using GNU Stow.

## Structure
Each top-level directory concerns a program or functionality. They mimick the
expected structure in `$HOME`. This is why pretty much every folder in this
repo has a `.config/` inside it.

I tried to make it as modular as I could, but there is some connection between
different programs. For example, the reason why I put my scripts in
`~/.local/bin` is because I add it to my `$PATH` in my bashrc, so every
directory with `.local/bin` has an implicit dependency on the "bash" directory.
I'm not going to document any dependencies and will just expect any users to
fix the issues themselves.

## Installation
Create symlinks to everything in `~` using GNU Stow:
```sh
$ stow */ -t ~/
```

You may also pick and choose specific programs to link:
```sh
$ stow bash sway -t ~/
```
