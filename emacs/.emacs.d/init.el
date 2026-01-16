(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Remove junk
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;; Appearance
(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-one t))

(set-frame-font "JetBrains Mono 14" nil t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Ido completion (comes with Emacs)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Have emacs change custom.el instead of here
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package magit
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package multiple-cursors
  :ensure t
  :config
  (
   ))

;; Edit this file quickly
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

;; Ignore casing when searching with project.el
(setq read-file-name-completion-ignore-case t)

(set-language-environment "UTF-8") ;; If you deliberately sabotage my diacritics I will f*ck you like a pig!

(when (eq system-type 'windows-nt)
  (setq default-directory (concat (getenv "USERPROFILE") "/")))

;; It was kind of a pain to get GNU Stow-like functionality in Windows so I'll just have Emacs do it for me.
(when (eq system-type 'windows-nt)
  (defun sync-emacs-config ()
    (let* ((user (file-name-as-directory (getenv "USERPROFILE")))
           (dot (file-name-as-directory (file-truename (concat user "Code/dotfiles/emacs/.emacs.d"))))
           (app (file-name-as-directory (file-truename "~/.emacs.d")))
           (cur (file-truename (buffer-file-name)))
           (base (file-name-nondirectory cur))
           (target (cond ((string-prefix-p dot cur t) (concat app base))
			 ((string-prefix-p app cur t) (concat dot base)))))
      (when (and target (member base '("init.el")))
	(copy-file cur target t)
	(message "Synced current buffer to: %s" target))))
  (add-hook 'after-save-hook #'sync-emacs-config))
