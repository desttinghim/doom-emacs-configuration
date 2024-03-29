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
(setq projectile-project-search-path '("~/Code/"))

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

(load! "dialog.el")
(load! "jasmin.el")
(load! "vala-mode.el")

(setq org-latex-compiler "lualatex")
(setq org-preview-latex-default-process 'dvisvgm)

(use-package! dash-docs
  :config
  (setq dash-docs-docsets-path "~/.local/share/Zeal/Zeal/docsets"))

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

(add-hook! 'prog-mode-hook 'sourcegraph-mode)

(use-package! wren-mode
  :mode ("\\.wren" . 'wren-mode))
