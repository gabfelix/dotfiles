;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Remove junk
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
;(scroll-bar-mode -1)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;; Appearance
(load-theme 'cobalt2 t)
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "#3AD900"))))
 '(font-lock-doc-face ((t (:foreground "#3AD900"))))
)
(when (eq system-type 'windows-nt)
  (set-frame-font "Roboto Mono 11" nil t))
(blink-cursor-mode 0) ;; Stop blinking cursor

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Have emacs change custom.el instead of here
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package typescript-mode
  :ensure t)

(use-package magit
  :ensure t)
