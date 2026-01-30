(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Remove junk
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq visible-bell 1) ; Turn off the annoying bell

(setq backup-directory-alist `(("." . "~/.config/emacs/emacs_saves")))

(setq vc-follow-symlinks t) ; Always follow the symlink (for GNU Stow)

(global-set-key (kbd "C-c c") 'compile)
;; The default bindings are pretty bad on Brazilian kb layout
(global-set-key (kbd "C-x [") 'previous-error)
(global-set-key (kbd "C-x ]") 'next-error)

;; Have emacs change custom.el instead of here
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package naysayer-theme
  :ensure t
  :config
  (load-theme 'naysayer t))

(use-package ripgrep
  :ensure t)

(use-package magit
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package multiple-cursors
  :ensure t
  :init
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package vertico
  :ensure t
  :init
  (vertico-mode t))

(use-package vertico-prescient
  :ensure t
  :after vertico
  :config
  (vertico-prescient-mode 1)
  (prescient-persist-mode 1))

(use-package projectile
  :requires ripgrep
  :ensure t
  :init
  (setq projectile-project-search-path
        (list (expand-file-name 
               "Code/"
               (or (getenv "USERPROFILE") ; Windows
                   (getenv "HOME"))))) ; Everywhere else
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (global-set-key (kbd "C-c p") 'projectile-command-map)
  (global-set-key (kbd "C-c f") 'projectile-ripgrep)
  (projectile-mode +1))

;; Edit this file quickly
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

;; Ignore casing when searching with project.el
(setq read-file-name-completion-ignore-case t)

(set-language-environment "UTF-8") ; If you deliberately sabotage my diacritics I will f*ck you like a pig!

(when (eq system-type 'windows-nt)
  (setq default-directory (concat (getenv "USERPROFILE") "/")))

;; Keep our font selections OS and Emacs server-agnostic
(defun my/set-font-faces (fixed-font var-font fixed-size var-size)
  (message "Setting faces")
  (set-face-attribute 'default nil :font fixed-font :height fixed-size)
  (set-face-attribute 'fixed-pitch nil :font fixed-font :height fixed-size)
  (set-face-attribute 'variable-pitch nil :font var-font :height var-size :weight 'regular))

(setq windows-mono-font "Consolas"
      windows-mono-font-size 11
      windows-var-font "Segoe UI"
      windows-var-font-size 11
      
      linux-mono-font "DejaVu Sans Mono"
      linux-mono-font-size 12
      linux-var-font "Ubuntu Sans"
      linux-var-font-size 12)

(if (daemonp)
    (add-hook 'server-after-make-frame-hook
              (lambda ()
                (cond 
                 ((eq system-type 'gnu/linux) 
                  (my/set-font-faces linux-mono-font linux-var-font 120 120))
                 ((eq system-type 'windows-nt) 
                  (my/set-font-faces windows-mono-font windows-var-font 120 120)))))
  ;; Non-daemon config
  (cond
   ((eq system-type 'gnu/linux) 
    (set-frame-font (format "%s-%d" linux-mono-font linux-mono-font-size) nil t))
   ((eq system-type 'windows-nt) 
    (set-frame-font (format "%s-%d" windows-mono-font windows-mono-font-size) nil t))))

;; Fix error location syntax for Typescript on Windows
(when (eq system-type 'windows-nt)
  ;; Can't get Stow to work in Windows so I'll just copy the config with Emacs
  (defun sync-emacs-config ()
    (let* ((user (file-name-as-directory (getenv "USERPROFILE")))
           (dot (file-name-as-directory (file-truename (concat user "Code/dotfiles/emacs/.config/emacs"))))
           (app (file-name-as-directory (file-truename "~/.emacs.d")))
           (cur (file-truename (buffer-file-name)))
           (base (file-name-nondirectory cur))
           (target (cond ((string-prefix-p dot cur t) (concat app base))
			 ((string-prefix-p app cur t) (concat dot base)))))
      (when (and target (member base '("init.el")))
	(copy-file cur target t)
	(message "Synced config file to: %s" target))))
  (add-hook 'after-save-hook #'sync-emacs-config)
  ;; Fix compile-mode broken color codes
  ;; TODO: This might be a windows specific issue, investigate
  (add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
  (eval-after-load 'compile
    '(progn
       ;; Full path
       (add-to-list 'compilation-error-regexp-alist 'windows-absolute)
       (add-to-list 'compilation-error-regexp-alist-alist
                    '(windows-absolute
                      "^\\([a-zA-Z]:[^:(\t\n]+\\):\\([0-9]+\\):\\([0-9]+\\)"
                      1 2 3))
       
       ;; Relative
       (add-to-list 'compilation-error-regexp-alist 'typescript-path)
       (add-to-list 'compilation-error-regexp-alist-alist
                    '(typescript-path
                      "^\\([^:\n]+\\.ts\\):\\([0-9]+\\):\\([0-9]+\\)"
                      1 2 3)))))
