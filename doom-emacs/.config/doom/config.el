;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jakob Helmecke"
      user-mail-address "j.helmecke@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dokumente/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


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
(setq doom-leader-key ",")
(setq doom-localleader-key ";")

(map!
 ;; Easier window navigation
 :n "C-h"   #'evil-window-left
 :n "C-j"   #'evil-window-down
 :n "C-k"   #'evil-window-up
 :n "C-l"   #'evil-window-right)

(evil-define-command my-git(arg)
  (message "%s" arg))

(evil-ex-define-cmd "Git" 'my-git)

(require 'ivy-ghq)

(defun ivy-ghq--open-cd (file)
  (cd
   (if ivy-ghq-short-list
       (format "%s%s" (ivy-ghq--get-root) file)
     (format "%s" file))))

(defun ivy-ghq-cd ()
  "Use `ivy-completing-read' to \\[cd] a ghq list"
  (interactive)
  (let ((path (ivy-completing-read "Find ghq repo.: "
                                   (ivy-ghq--list-candidates))))
    (if (ivy-ghq--open-cd path)
        (message (format "Directory %s" path)))))

;;(add-hook 'dired-mode-hook 'centaur-tabs-local-mode)

(map! :leader
      :desc "Find ghq repository"
      "f g" #'ivy-ghq-cd)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
  '(bar workspace-name window-number modals matches vcs buffer-info remote-host)
  '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode buffer-position word-count parrot selection-info process checker))
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
)
