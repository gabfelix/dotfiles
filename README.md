# dotfiles
These are my personal configuration files and scripts managed using GNU Stow.

## Structure
The system is divided into modules, represented by the top-level directories. The structure inside each module mimicks the target structure in the `$HOME` directory. This is why pretty much every folder has a `.config` inside it.

I tried to make it as modular as I could, but there is some connection between different programs. For example, the reason why I can put my scripts in `~/.local/bin` is because I add it to my `$PATH` in my bashrc, so every directory with `.local/bin` has an implicit dependency on the "bash" directory.

I don't use all of these anymore, but I figured there might be some use for the config. This is why there are configs for conflictin programs, like different window managers.

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
## Additional settings
These are some additional settings which need manual intervention.

### Natural Scrolling
On Wayland, this is usually handled by the compositor itself.

For X11, you need to set up natural scrolling by editing `/usr/share/X11/xorg.conf.d/40-libinput.conf`. I like doing this only for the touchpad. To do so, look for the touchpad config and make it look like this:

```
Section "InputClass"
    ...
    MatchIsTouchpad "on"
    ...
    Option "NaturalScrolling" "True"
```

### GTK
> NOTE: As of GNOME 48, "Adwaita Sans" (which is just a modified version of Inter) is the new default font, so you might not need to do this anymore.

Set the font in GTK to `Inter` or anything else you want with
```sh
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
```

### Vim
If you're installing the `vim` module, you need to install the `vim-plug` plugin manager manually. Check out [vim-plug's installation instructions for vim](https://github.com/junegunn/vim-plug?tab=readme-ov-file#vim).

After installing vim-plug, install the plugins by opening vim and running:
```
:PlugInstall
```

### MPD playlists
My MPD + ncmpcpp setup expects the existence of the `~/mus` and `~/mus/playlists` directories.

### ZSH
The `zsh` module expects the existence of the **file** `~.cache/zsh/history`. If it's not found, an error will be emitted every time you leave a session. This isn't visible during normal usage, but it can get annoying if you ever need to call `zsh` manually.

I am no longer using zsh and am just keeping it in the repo because, well, why not?

### Fish
I use the fish shell, but I since it's not POSIX compatible, (I don't set it as my default shell)[https://tim.siosm.fr/blog/2023/12/22/dont-change-defaut-login-shell/]. Instead, I configure my terminal (alacritty) to use fish.

What this means is that the `fish` module might require some stuff from the `bash` module to work. For example, since my login shell is still the default (bash), I need to configure auto-starting Hyprland on TTY1 in my `.bash_profile`, because fish doesn't run when I login, only when I open Alacritty.

## Modules
Small observations about certain modules:

- Most modules in this repository are better installed with `--no-folding` because it avoids miscellaneous files, which is why the `stowit.sh` script was added. However, some modules like `nvim`, whose structure constantly changes between commits, work better when installed with folding. However, in order to enable the use of the `nvim` module with `--no-folding`, there is some *"restow"* code in my neovim config which removes broken symlinks and re-deploys the module whenever a change to the `nvim` module in this  repo is detected. This ensures `~/.config/nvim` always has all the new files. It is important to note that this setup is *not* bidirectional. New files added to `~/.config/nvim` will *not* be automatically copied into the module in this repo, so you should always edit the config here first and let neovim handle the rest.

## Packages
Some programs you'll need in order to make the setup work.
I can't promise that this list is exhaustive, but I just did a fresh reinstall so everything should be here.
All packages are using Arch names.

### Official repos

- `udisks2`
- `udisks2-btrfs`
- `udisks2-lvm2`
- `stow`
- `hyprland`
- `hyprpaper`
- `hyprcursor`
- `waybar`
- `ttf-font-awesome`
- `tmux`
- `kitty`
- `gtk3` # unspecified kitty dependency (won't open otherwise)
- `imagemagick`
- `zsh`
- `zsh-completions`
- `zsh-syntax-highlighting`
- `starship`
- `rofi`
- `pipewire-pulse`
- `pipewire-alsa`
- `pipewire-jack`
- `yt-dlp`
- `mpv`
- `ffmpeg`
- `zathura`
- `zathura-cb`
- `zathura-pdf-mupdf`
- `lf`
- `atool`
- `ffmpegthumbnailer`
- `atool`
- `bat`
- `chafa`
- `colordiff`
- `mpd` # systemctl --user enable
- `ncmpcpp`
- `mako` # systemctl --user enable
- `noto-fonts`
- `noto-fonts-cjk`
- `noto-fonts-emoji`
- `noto-fonts-extra`
- `pulsemixer`
- `libnotify`
- `slurp`
- `grim`
- `neovim`
- `wl-clipboard`
- `ripgrep`
- `fzf`
- `just`
- `jq`
- `imv`
- `zip`
- `unzip`
- `newsboat`
- `bluez` # systemctl enable bluetooth
- `bluez-utils` # optional (has a command line utility for bluetooth, blueman's applet already provides GUI)
- `blueman`
- `urlscan`

### i3 Packages
I recently had to return to i3 because of bad performance on my external monitor with the NVIDIA driver under Wayland. This happened on GNOME and Hyprland, so I'm just going back, at least for now.

These are put on top of the previous hyrpland setup's packages, so there is some overlap and common dependencies I'm not putting in because they're already listed above (example: I have `dunst` in here, but not `libnotify`.

- `i3-wm`
- `xorg`
- `xorg-xinit`
- `i3status`: Default status bar
- `dmenu`: Default launcher
- `feh`: Setting wallpaper
- `dunst`: Notifications
- `xclip`: Clipboard

### AUR

- `paru-bin` # The AUR helper I use, install this first
- `nvm`
- `librewolf-bin`
