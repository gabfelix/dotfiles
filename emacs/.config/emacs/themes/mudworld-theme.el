(deftheme mudworld
  "A high-contrast, earth-toned theme.")

(let ((class '((class color) (min-colors 89)))
      (bg              "#000000")
      (fg              "#cdaa7d")
      (bg-faded        "#7d6d59")
      (white           "#ffffff")
      (orange          "#cf7044")
      (blue            "#5b909a")
      (grey-light-blue "#bac4cf")
      (yellow          "#f1c84b")
      (darker-yellow   "#c78b3d")
      (muted-purple    "#9b6f8d")
      (green           "#6c9a5b")
      (pure-blue       "#0000ff")
      (pure-cyan       "#00ffff"))

  (custom-theme-set-faces
   'mudworld

   ;; --- Base UI ---
   `(default ((,class (:foreground ,fg :background ,bg))))
   `(cursor ((,class (:background ,fg))))
   `(fringe ((,class (:background ,bg :foreground ,bg-faded))))
   `(minibuffer-prompt ((,class (:foreground ,yellow :bold t))))
   `(region ((,class (:background ,pure-blue :foreground ,pure-cyan))))
   `(secondary-selection ((,class (:background ,bg-faded :foreground ,bg))))

   `(mode-line ((,class (:foreground ,bg :background ,fg :box nil))))
   `(mode-line-inactive ((,class (:foreground ,bg-faded :background ,fg :box nil))))

   `(line-number ((,class (:foreground ,bg-faded :background ,bg))))
   `(line-number-current-line ((,class (:foreground ,fg :background ,bg :bold t))))

   `(isearch ((,class (:foreground ,bg :background ,orange :bold t))))
   `(lazy-highlight ((,class (:foreground ,bg :background ,darker-yellow))))

   `(font-lock-comment-face ((,class (:foreground ,green :slant italic))))
   `(font-lock-doc-face ((,class (:foreground ,green :slant italic))))

   `(font-lock-string-face ((,class (:foreground ,orange))))

   `(font-lock-keyword-face ((,class (:foreground ,yellow))))
   `(font-lock-builtin-face ((,class (:foreground ,yellow))))

   `(font-lock-function-name-face ((,class (:foreground ,white :bold t))))

   `(font-lock-constant-face ((,class (:foreground ,muted-purple :bold t))))
   `(font-lock-warning-face ((,class (:foreground ,orange :bold t))))

   `(font-lock-type-face ((,class (:foreground ,blue :bold t))))

   `(font-lock-variable-name-face ((,class (:foreground ,fg))))

   `(font-lock-preprocessor-face ((,class (:foreground ,darker-yellow))))
   `(font-lock-negation-char-face ((,class (:foreground ,fg))))

   `(font-lock-bracket-face ((,class (:foreground ,fg))))
   `(font-lock-delimiter-face ((,class (:foreground ,fg))))
   `(font-lock-operator-face ((,class (:foreground ,fg))))
   `(font-lock-misc-punctuation-face ((,class (:foreground ,fg))))

   `(org-level-1 ((,class (:foreground ,yellow :bold t :height 1.1))))
   `(org-level-2 ((,class (:foreground ,orange :bold t))))
   `(org-level-3 ((,class (:foreground ,blue :bold t))))
   `(org-level-4 ((,class (:foreground ,muted-purple :bold t))))
   `(org-code ((,class (:foreground ,orange))))
   `(org-hide ((,class (:foreground ,bg))))
   `(org-date ((,class (:foreground ,blue :underline t))))
   `(org-block ((,class (:background ,bg))))
   `(org-block-begin-line ((,class (:foreground ,bg-faded :slant italic))))
   `(org-block-end-line ((,class (:foreground ,bg-faded :slant italic))))

   `(completions-common-part ((,class (:foreground ,blue))))
   `(completions-first-difference ((,class (:foreground ,orange :bold t))))
   ))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'mudworld)
