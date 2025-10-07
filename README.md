# dotfiles

Personal configuration files and scripts managed with **GNU Stow**.

Originally, this repo was meant to be a ready-to-deploy setup for `$HOME` using `./stowit.sh */`, while still allowing selective installs. Over time, configs for different tools piled up — some of which I don’t use daily but keep around as references.  

So, if you find some conflicting or legacy configs here, that’s intentional. Consider this a living archive of setups that have worked for me at different times.

---

## 📁 Structure

Each top-level directory is a **module**, mirroring its target structure under `$HOME`.  
For example, most modules contain a `.config` directory.

Although the modules are mostly independent, some have implicit dependencies — e.g., anything using `~/.local/bin` depends on `bash`, since `$PATH` is extended in `.bashrc`.

I’m not interested in documenting all interdependencies. If you fork or reuse this setup, you’ll need to troubleshoot and patch things up yourself — ideally sending improvements back my way 😄.

---

## ⚙️ Installation

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

### Using the Wrapper Script

`stowit.sh` wraps around GNU Stow for convenience. It uses `--no-folding` by default.

```sh
./stowit.sh */
```

Or just a few modules:

```sh
./stowit.sh bash sway
```

---

## 🧩 Modules and Notes

### Neovim (`nvim` vs `nvim-nightly`)
- `nvim/`: legacy config (Kickstart-based, using the [lazy.nvim](https://github.com/folke/lazy.nvim) package manager)  
- `nvim-nightly/`: new config using Neovim’s native `vim.pack` package manager (similar to [mini.deps](https://github.com/nvim-mini/mini.deps))

The new setup aims to:
1. Work on both Linux and Windows  
2. Minimize dependencies (external features should be optional where possible)  
3. Keep most config in a single `init.lua`, splitting only where logical (e.g., `ftplugin`)

Because I’m still transitioning, both configs coexist for now.

---

### Shells

#### Bash
Other shells may rely on it for environment setup.

#### Zsh
Requires `~/.cache/zsh/history` (a file, not a directory) to exist — otherwise it’ll throw a harmless but annoying error.  
I don’t actively use Zsh anymore, but I keep it here for reference.

#### Fish
I also don't use Fish anymore.

Fish isn’t POSIX-compliant, so I don’t set it as the default login shell — instead, my terminal (Alacritty or Kitty) launches it.  
Because Bash runs first at login, auto-start logic (like Hyprland on TTY1) still lives in `.bash_profile`.

Reference: [Don’t change your default login shell](https://tim.siosm.fr/blog/2023/12/22/dont-change-defaut-login-shell/)

---

### lf (File Manager)
To enable video previews, install:
- `jq`
- `ffmpegthumbnailer`

The previewer script `vidthumb` uses those tools to generate thumbnails and a JSON manifest for caching.

For easier previews without extra configuration, you may want to opt for [yazi](https://github.com/sxyazi/yazi) and the [kitty terminal](https://github.com/kovidgoyal/kitty) for terminal file management. Just install the dependencies and you're set.

---

### Vim
If you use the `vim` module:
1. Install [vim-plug](https://github.com/junegunn/vim-plug?tab=readme-ov-file#vim)
2. Open Vim and run:
   ```
   :PlugInstall
   ```

---

### MPD
Create these directories:
```sh
mkdir -p ~/mus/playlists
```
They’re required for MPD + ncmpcpp to work properly.

---

## 🧠 System Tweaks

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

---

## 🧰 Packages

Here’s a rough package list (Arch names). It’s not exhaustive or guaranteed current — things change often.

### Official Repos
```
udisks2 udisks2-btrfs udisks2-lvm2 stow hyprland hyprpaper hyprcursor waybar
ttf-font-awesome tmux kitty gtk3 imagemagick zsh zsh-completions
zsh-syntax-highlighting starship rofi pipewire-pulse pipewire-alsa
pipewire-jack yt-dlp mpv ffmpeg zathura zathura-cb zathura-pdf-mupdf
lf atool ffmpegthumbnailer bat chafa colordiff mpd ncmpcpp mako
noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
ttf-jetbrains-mono ttf-jetbrains-mono-nerd pulsemixer libnotify
slurp grim neovim wl-clipboard ripgrep fzf just jq imv zip unzip
newsboat bluez bluez-utils blueman urlscan lazygit uwsm
```

### AUR
```
paru-bin
```

---

## 💡 Special Notes on Stowing

Most modules are best installed with `--no-folding`, hence the `stowit.sh` default.  
However, `nvim` changes structure often, so folding it may work better.  

The Neovim config includes a helper script `restow.lua` that:
- Cleans broken symlinks
- Redeploys updated files when the repo changes  
*(Not bidirectional — edits in `~/.config/nvim` won’t sync back automatically.)*

---

## 🙌 Credits

Huge thanks to these projects for inspiration and code snippets:

- [Luke Smith’s voidrice](https://github.com/LukeSmithxyz/voidrice) — my starting point for dotfile management and shell scripting.  
- [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles) — tmux utilities like the [sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer).  
- [Sylvan Franklin](https://github.com/SylvanFranklin/.config) — ideas for Telescope and Neovim structure.  
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — the base for my second Neovim config.  
