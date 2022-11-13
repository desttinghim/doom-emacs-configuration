;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Identity
(setq user-full-name "Louis Pearson"
      user-mail-address "opensource@louispearson.work")

;; Visual configuration
(setq doom-theme 'doom-dracula)
(setq doom-font
      (font-spec :name "Source Code Pro"
                 :family "monospace"
                 :size 14))
(setq doom-variable-pitch-font
      (font-spec :name "Overpass" :family "sans" :size 14))

;; nil -> no line numbers, t -> absolute, or 'relative
(setq display-line-numbers-type 'relative)

;; Org configuration
(setq org-directory "~/Documents/org/")
(setq org-journal-file-type 'weekly)
;; (add-to-list 'org-capture-templates
;;              ("w" "Web site" entry
;;               (file "")
;;               "* %a :website:\n\n%U %?\n\n%:initial"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Automatically starts sqlup-mode when sql-mode starts.
(use-package! sqlup-mode
  :hook (sql-mode sql-interactive-mode))

;; Tell projectile the default search path for projects
(setq projectile-project-search-path '("~/repos/"))

;; elfeed configuration
(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread")
  (add-hook! 'elfeed-search-mode-hook 'elfeed-update)
  (setq rmh-elfeed-org-files (list "~/Documents/Desttinghim Sync/org/elfeed.org")))

(after! org-msg
  (setq org-msg-options "html-postamble:nil toc:nil H:5 num:nil ^:{} "
        org-msg-startup "hidestars indent inlineimages"
        org-msg-greeting-fmt "\n%s, \n\n"
        org-msg-signature "#+begin_signature\n-- Louis Pearson\n#+end_signature"))

(doom-load-envvars-file "~/.config/emacs/.local/env")

;; (use-package! 'generic-x
;;   (define-generic-mode
;;       'dialogc-mode                     ;; name of the mode to create
;;     '("%%")                             ;; comments start with %%
;;     nil                                 ;; some keywords
;;     '(("#\\w+?\\b" . 'font-lock-constant-face)
;;       ("$\\w*?\\b" . 'font-lock-variable-name-face)
;;       ("~" . 'font-lock-negation-char-face)
;;       ("(\\(?:\\(?:[$#]\\w+\\)\\|\\([[:alnum:]-+_]+\\)\\|\\(\\*\\)\\|\\(?: \\)\\)+)"
;;        (1 'font-lock-function-name-face)
;;        (2 'font-lock-preprocessor-face))
;;       )
;;     '("\\.dg$")                         ;; files for which to activate this mode
;;     nil                                 ;; other functions to call
;;     "Major mode for editing dialogc story files"    ;; doc string for mode
;;     ))

(load! "dialog.el")

(setq org-latex-compiler "lualatex")
(setq org-preview-latex-default-process 'dvisvgm)

(setq dash-docs-docsets-path "~/.local/share/Zeal/Zeal/docsets")

;; Turtle mode (for making LV2 plugins)
(autoload 'ttl-mode "ttl-mode" "Major mode for OWL or Turtle files" t)
(add-hook 'ttl-mode-hook    ; Turn on font lock when in ttl mode
          'turn-on-font-lock)
(setq auto-mode-alist
      (append
       (list
        '("\\.n3" . ttl-mode)
        '("\\.ttl" . ttl-mode))
       auto-mode-alist))

(use-package! zig-mode
  :hook ((zig-mode . lsp-deferred))
  :custom (zig-format-on-save nil)
  :config
  (after! lsp-mode
    (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
    (lsp-register-client
      (make-lsp-client
        :new-connection (lsp-stdio-connection "<path to zls>")
        :major-modes '(zig-mode)
        :server-id 'zls))))

(add-hook! 'prog-mode-hook 'sourcegraph-mode)
