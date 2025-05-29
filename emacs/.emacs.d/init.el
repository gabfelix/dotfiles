;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Remove junk
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Ido completion
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Load theme with f7
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

(setq backup-directory-alist `(("." . "~/.emacs_saves")))

(load-theme 'modus-vivendi t)
(set-face-attribute 'default nil
                    :family "DejaVu Sans Mono"
		    :height 120)

(use-package magit
  :ensure t)

;; Have emacs change custom.el instead of here
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
