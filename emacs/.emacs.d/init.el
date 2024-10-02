(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq backup-directory-alist `(("." . "~/.saves")))

(set-frame-font "Iosevka Nerd Font 18" nil t)

(use-package gruber-darker-theme
  :ensure
  :config
  (load-theme 'gruber-darker t)
)

(use-package magit
  :ensure
)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq-default show-trailing-whitespace t)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
