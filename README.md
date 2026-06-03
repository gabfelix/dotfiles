# dotfiles

Personal configuration files and scripts managed with **GNU Stow**.

## Structure

Each top-level directory is a **module**, mirroring its target structure under `$HOME`.  
For example, most modules contain a `.config` directory.

Although the modules are mostly independent, some have implicit dependencies — e.g., anything using `~/.local/bin` depends on `bash`, since `$PATH` is extended in `.bashrc`.

I’m not interested in documenting all interdependencies. If you fork or reuse this setup, you’ll need to troubleshoot and patch things up yourself.

## Special Notes on Stowing
Most modules are best installed with `--no-folding`, hence the `stowit.sh` default.  
However, `nvim` changes structure often, so folding it may work better. This must be decided on a module-by-module basis.

## Installation

### Using the Wrapper Script

`stowit.sh` is a helper script that wraps `stow`. It uses `--no-folding` by default.

```sh
./stowit.sh */
```

Or just a few modules:

```sh
./stowit.sh bash sway
```

### Using GNU Stow

From inside the cloned repo, you can symlink all modules into your home directory:

```sh
stow */ -t ~
```

Or selectively stow a few:

```sh
stow bash sway -t ~
```

To prevent Stow from linking entire directories (and thus syncing unwanted junk like logs), use:

```sh
stow --no-folding bash sway -t ~
```

> Note: using `--no-folding` makes it harder to track new files — you’ll need to copy them manually into the repo later.

To **unstow** a module:

```sh
stow -D bash -t ~
```

To switch shells, for instance:

```sh
stow -D bash -t ~
stow --no-folding zsh -t ~
```

### lf (File Manager)
To enable video previews, install:
- `jq`
- `ffmpegthumbnailer`

The previewer script `vidthumb` uses those tools to generate thumbnails and a JSON manifest for caching.

For easier previews without extra configuration, you may want to opt for [yazi](https://github.com/sxyazi/yazi) and the [kitty terminal](https://github.com/kovidgoyal/kitty) for terminal file management. Just install the dependencies and you're set.

### MPD
Create these directories:
```sh
mkdir -p ~/mus/playlists
```
They’re required for MPD + ncmpcpp to work without complaining about missing directories.

## System Tweaks

### Natural Scrolling

- **Wayland:** handled by the compositor  
- **X11:** edit `/usr/share/X11/xorg.conf.d/40-libinput.conf` and add:

  ```
  Section "InputClass"
      ...
      MatchIsTouchpad "on"
      Option "NaturalScrolling" "True"
  ```

### GTK Font

> As of GNOME 48, “Adwaita Sans” (a variant of Inter) is the default, so this may no longer be necessary.

Set the font manually if needed:
```sh
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
```

### Ignoring newsboat urls for this repo
I like having the `urls` file in the repo to make it more complete. Newsboat can then open without any errors, but I don't want my RSS feeds all over GitHub, so I do the following to ignore my local changes to urls AFTER stowing:

```sh
echo './newsboat/.config/newsboat/urls' >> .git/info/exclude
git update-index --assume-unchanged newsboat/.config/newsboat/urls`
```
This will ignore all current and future changes to the file, while still keeping it checked into the repo, unchanged.

## Packages
Removed. See the `pkgs.sh` script for an Arch package list.

## Credits

Huge thanks to these projects for inspiration and code snippets:

- [Luke Smith’s voidrice](https://github.com/LukeSmithxyz/voidrice) — Luke's stuff is what got me into tiling window managers and terminal apps. Learned most of this stuff from reading his dotfiles and scripts, many files here are just copies of his.  
- [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles) — tmux utilities like the [sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer).  
- [Sylvan Franklin](https://github.com/SylvanFranklin/.config) — ideas for Telescope and Neovim structure.  
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — the initial base for the long line of configs and rewrites I use to this day.
