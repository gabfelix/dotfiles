# dotfiles
These are my personal configuration files and scripts managed using GNU Stow.

The idea initially was for this to be a complete setup you could just deploy to your `$HOME` with `./stowit.sh */` but still pick and choose if you wanted anything specific, but as I tried programs over the years, the configs kept piling up and I didn't want to remove them in case I needed the reference when/if I tried them again. So a lot of these don't see any use from me in my day-to-day.

The README itself isn't very organized as well, there's *some* structure to it, but it's mostly a big stack of miscellaneous notes on the various programs I'm using.

With that in mind, let's get to the configs and setup notes, I hope you find something useful here.

# Structure
The system is divided into modules, represented by the top-level directories. The structure inside each module mimicks the target structure in the `$HOME` directory. This is why pretty much every folder has a `.config` inside it.

I tried to make it as modular as I could, but there is some connection between different programs. For example, the reason why I can put my scripts in `~/.local/bin` is because I add it to my `$PATH` in my bashrc, so every directory with `.local/bin` has an implicit dependency on the "bash" directory.

I don't use all of these anymore, but I figured there might be some use for the config. This is why there are configs for conflictin programs, like different window managers.

Since these are my personal configurations and this is (at the time of writing) a private repository, I won't make any effort to document such dependencies. Should this repository become public, any potential users of these files are expected to fix the issues themselves and (if possible) contribute a fix back.

## nvim x nvim-nightly?
> TL;DR: nvim/ = old config, nvim-nightly/ = new config

At the time of writing this README, neovim has a new native package manager in the "nightly" version called `vim.pack`, which is modeled after [mini.deps](https://github.com/nvim-mini/mini.deps). I decided to switch to it because I really like the idea of hitting the ground running instead of having to install a package manager with curl on startup, so I'm rewriting my config to:
1. Work well with Windows as well as Linux
2. Require as little dependencies as possible (features that require external dependencies should be optional)
3. Be mostly comprised of a single, dumb, big `init.lua`, as I haven't actually gotten many benefits from the multi-file structure suggested by kickstart. It's mostly been a lot of jumping around. I'll only be splitting files where it makes sense, like `ftplugin`

Since I don't want to break the old [kickstart](https://github.com/nvim-lua/kickstart.nvim)-based config as I do this, so I'm making a new stow module for it. This is what `nvim-nightly/` is.

# Installation
## GNU Stow

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

# Additional settings
These are some additional settings which need manual intervention.

## Natural Scrolling
On Wayland, this is usually handled by the compositor itself.

For X11, you need to set up natural scrolling by editing `/usr/share/X11/xorg.conf.d/40-libinput.conf`. I like doing this only for the touchpad. To do so, look for the touchpad config and make it look like this:

```
Section "InputClass"
    ...
    MatchIsTouchpad "on"
    ...
    Option "NaturalScrolling" "True"
```

## GTK
> NOTE: As of GNOME 48, "Adwaita Sans" (which is just a modified version of Inter) is the new default font, so you might not need to do this anymore.

Set the font in GTK to `Inter` or anything else you want with
```sh
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
```

## Vim
If you're installing the `vim` module, you need to install the `vim-plug` plugin manager manually. Check out [vim-plug's installation instructions for vim](https://github.com/junegunn/vim-plug?tab=readme-ov-file#vim).

After installing vim-plug, install the plugins by opening vim and running:
```
:PlugInstall
```

## MPD playlists

My MPD + ncmpcpp setup expects the existence of the `~/mus` and `~/mus/playlists` directories.

## ZSH

The `zsh` module expects the existence of the **file** `~.cache/zsh/history`. If it's not found, an error will be emitted every time you leave a session. This isn't visible during normal usage, but it can get annoying if you ever need to call `zsh` manually.

I am no longer using zsh and am just keeping it in the repo because, well, why not?

## Fish

I use the fish shell, but I since it's not POSIX compatible, (I don't set it as my default shell)[https://tim.siosm.fr/blog/2023/12/22/dont-change-defaut-login-shell/]. Instead, I configure my terminal (alacritty) to use fish.

What this means is that the `fish` module might require some stuff from the `bash` module to work. For example, since my login shell is still the default (bash), I need to configure auto-starting Hyprland on TTY1 in my `.bash_profile`, because fish doesn't run when I login, only when I open Alacritty.

## lf and Previews

To see video thumbnail previews, the previewer uses a script called `vidthumb` that requires `jq` and `ffmpegthumbnailer`. The cache it creates for the image has a JSON manifest created/parsed with `jq`, so don't forget to install it!

# Modules

Small observations about certain modules:

- Most modules in this repository are better installed with `--no-folding` because it avoids miscellaneous files, which is why the `stowit.sh` script was added. However, some modules like `nvim`, whose structure constantly changes between commits, work better when installed with folding. However, in order to enable the use of the `nvim` module with `--no-folding`, there is a file called `restow.lua` in my neovim config which removes broken symlinks and re-deploys the module whenever a change to the `nvim` module in this  repo is detected. This ensures `~/.config/nvim` always has all the new files. It is important to note that this setup is *not* bidirectional. New files added to `~/.config/nvim` will *not* be automatically copied into the module in this repo, so you should always edit the config here first and let neovim handle the rest.

## Packages

A list of packages you'll need in order to make the setup work. All packages are using Arch names.
I can't guarantee that this list is correct. The programs and their dependencies change all the time either by the changes I make here or the ones by the many maintainers involved in all these projects and it's a massive pain to keep it up to date. This is what I had from the notes I took during an Arch reinstall a few months ago and a few manual edits thereafter:

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
- `ttf-jetbrains-mono`
- `ttf-jetbrains-mono-nerd`
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
- `lazygit`
- `uwsm`

### AUR

I try not to pull too much stuff from the AUR for the default setup for security concerns.

- `paru-bin` # The AUR helper I use, install this by cloning first

# Credits

These repos were a great help for inspiration and reference in writing all this stuff.

- [Luke Smith's voidrice]( https://github.com/LukeSmithxyz/voidrice ): Luke's videos were what got me started on Linux and terminal applications. I learnt shell scripting by reading his code. My setup is heavily based on his. Some of the configs in this repo are just copied straight from his.
- [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles): Mostly took prime's tmux stuff, like his [sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer) script.
- [Sylvan Franklin](https://github.com/SylvanFranklin/.config): Telescope configs and took some ideas for my `init.lua`
- [Kickstart](https://github.com/nvim-lua/kickstart.nvim): Used this as the base for my neovim config in the second rewrite. I had a custom LSP setup I hated maintaining and this gave me something semi-automatic that worked. I mostly removed stuff I didn't care about from it.
