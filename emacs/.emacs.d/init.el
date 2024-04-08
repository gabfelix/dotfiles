;; TODO:
;; - Switch automatically when creating new pane (C-2, C-3)
;; - Line moving
;; - Easy line copying
;; - Kill entire line from inside it
;; - Multiline cursor
;; - Learn magit
;; - LSP, treesitter, etc.
;; - Projectile
;; - Projectile+Godot: Run scene from emacs (no alt-tabbing to godot)
;; - Setup ibuffer keymap
;; - "compile" command
;; - Look into this:
;; It's also worth pointing out to beginners that, searching and other moving commands, set the buffer "mark" where you were before searching/moving.
;; The mark is like a second cursor which is set by some actions, and the space between the mark and the cursor (point) is known as the region. The region is like your selected text in other editors, but much more powerful.
;; Once you have searched, you can immediately enter a command that acts on the region, for example C-M-\, indent region. Or activate the region and replace occurrences. Or narrow the region. Or undo within the region (ignoring undo in other parts of the file). It's very flexible.
;; Another example: you paste some code. It automatically sets the mark where the cursor was before pasting. So you can go to the initial part where the code was pasted by just going to the previous mark using C-u C-SPC (every time the mark is set, it remembers the previous one). Or immediately indent the pasted code by pressing C-M-\ right after pasting.
;; And all of that is vanilla Emacs, out of the box!
;; - Learn to ACTUALLY use dired, including copying, cutting and doing other things with files!


(require 'server)
(unless (server-running-p)
  (server-start))

(defun load-windows-settings ()
  (let ((windows-settings "~/.emacs.d/init-windows.el"))
  (when (file-exists-p windows-settings)
    (load-file windows-settings))))

(when (window-system)
  (let ((os (system-name)))
    (when (equal os "windows")
      (load-windows-settings))))

;; Basic stuff, remove the clutter from the UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; Theme
(load-theme 'modus-vivendi t)
(set-cursor-color "#00ff00") ;; Lime green cursor

;; Minor modes
(show-paren-mode t) ;; Highlight parentheses
(goto-address-mode t) ;; Make links clickable
(global-auto-revert-mode t) ;; Update when file is changed outside Emacs
(save-place-mode t)
(delete-selection-mode 1) ;; Replace selection with text by default

;; Programming-exclusive minor modes
(defun enable-programmer-minor-modes ()
  (display-line-numbers-mode t)
  (electric-pair-mode t)
  (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook #'enable-programmer-minor-modes)

;; Stop cluttering my folders with backup files
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/autosaves" t)))

(require 'compile)

;; Package management
(require 'package)

;; hide customize message
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Update package list on new install
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package gdscript-mode)

(use-package markdown-mode
  :ensure t
  :hook (markdown-mode . visual-line-mode)
  :init
  (setq markdown-command "multimarkdown"))

(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :custom
  (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-enable-auto-quoting nil))

(use-package ruby-mode)

;; https://elpa.gnu.org/packages/vertico.html
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))
