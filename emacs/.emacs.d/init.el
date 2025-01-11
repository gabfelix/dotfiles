;; Remove junk
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
;(scroll-bar-mode -1)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))

(load-theme 'cobalt2 t)
(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "#3AD900"))))
 '(font-lock-doc-face ((t (:foreground "#3AD900"))))
)
(when (eq system-type 'windows-nt)
  (set-frame-font "Consolas 10" nil t))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Have emacs change custom.el instead of here
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
