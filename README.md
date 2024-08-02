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
The `stowit.sh` wrapper script can help the user quickly symlink config files to `$HOME` by wrapping around the `stow` command.
Note that `--no-folding` is enabled by default, which means it'll only symlink files, not directories.
Assuming you're inside this repository's cloned directory, run:

```sh
$ ./stowit.sh */
```

You may also pass specific modules, just like before:
```sh
$ ./stowit.sh bash sway
```

## Modules
Small observations about certain modules:

- The `lf` module contains a systemd service and timer for automatically clearing the cache in `$HOME/.cache` once a week. It is important to note that, should the `.timer` or the `.service` be disabled, their symlinks created by stow will ALSO be removed because systemd removes ALL links to the file.
- Most modules in this repository are better installed with `--no-folding` because it avoids miscellaneous files, which is why the `stowit.sh` script was added. However, some modules like `nvim`, whose structure constantly changes between commits, work better when installed with folding.

## Packages
Some programs you'll need in order to make the setup work.
I can't promise that this list is exhaustive, but I just did a fresh reinstall so everything should be here.
All packages are using Arch names.

### Official repos

* `udisks2`

* `udisks2-btrfs`

* `stow`

* `hyprland`

* `hyprpaper`

* `hyprcursor`

* `waybar`

* `tmux`

* `kitty`

* `gtk3` # unspecified kitty dependency (won't open otherwise)

* `imagemagick`

* `zsh`

* `zsh-completions`

* `zsh-syntax-highlighting`

* `starship`

* `wofi`

* `pipewire-pulse`

* `pipewire-alsa`

* `pipewire-jack`

* `ttf-sourcecodepro-nerd`

* `yt-dlp`

* `mpv`

* `ffmpeg`

* `zathura`

* `zathura-cb`

* `zathura-pdf-mupdf`

* `lf`

* `atool`

* `ffmpegthumbnailer`

* `atool`

* `bat`

* `chafa`

* `colordiff`


* `poppler` # Dependency for ctpv

* `mpd` # systemctl --user enable

* `ncmpcpp`

* `mako` # systemctl --user enable

* `noto-fonts`

* `noto-fonts-cjk`

* `noto-fonts-emoji`

* `noto-fonts-extra`

* `pulsemixer`

* `libnotify`

* `slurp`

* `grim`

* `neovim`

* `wl-clipboard`

* `ripgrep`

* `fzf`

* `just`

* `jq`

* `imv`

* `zip`

* `unzip`

* `newsboat`

* `otf-comicshanns-nerd `

* `ttf-jetbrains-mono-nerd`

* `ttf-font-awesome`

### AUR

* `paru-bin` # The AUR helper I use, install this first

* `nvm`

* `librewolf-bin`

* `ctpv`
