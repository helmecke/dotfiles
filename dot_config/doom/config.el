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
(setq doom-font (font-spec :family "MesloLGS Nerd Font" :size 13 :weight 'semi-light)
      doom-variable-pitch-font nil)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

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

(map! :n "-" #'dired-jump)
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

;; List todos from all org files
(load-library "find-lisp")
(setq org-agenda-files
   (find-lisp-find-files org-directory "\.org$"))

(after! org
        (setq org-roam-directory (concat org-directory "roam/")))

(setq org-roam-mode-sections
      (list #'org-roam-backlinks-section
            #'org-roam-reflinks-section
            #'org-roam-unlinked-references-section))

(setq org-roam-dailies-directory "journal/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%H:%M> %?"
         :if-new (file+head "%<%F>.org" "#+title: %<%a, %-d %b %Y>"))))

(setq org-journal-date-prefix "#+title: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %-d %b %Y"
      org-journal-file-format "%F.org")

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(map! :leader
      (:prefix ("r" . "roam")
               :desc "Capture to node" "r" #'org-roam-capture))

(map! :leader
      (:prefix ("j" . "journal")
               :desc "Capture today" "j" #'org-roam-dailies-capture-today
               :desc "Goto today" "J" #'org-roam-dailies-goto-today
               :desc "Capture yesterday" "y" #'org-roam-dailies-capture-yesterday
               :desc "Goto yesterday" "y" #'org-roam-dailies-goto-yesterday
               :desc "Capture tomorrow" "t" #'org-roam-dailies-capture-tomorrow
               :desc "Goto tomorrow" "T" #'org-roam-dailies-goto-tomorrow))

;; Fugitive muscle memory
(evil-ex-define-cmd "G" #'magit-status)

;;
(evil-define-command my-git(arg)
  (message "%s" arg))

(evil-ex-define-cmd "Git" 'my-git)

(require 'ivy-ghq)
(setq ivy-ghq-short-list t)

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

(map! :leader (:prefix ("g" . "git") :desc "ghq repository" "r" #'ivy-ghq-cd))

(setq magit-repository-directories '(("~/Git" . 3)))

(when (eq system-type 'darwin)
  (osx-trash-setup))
(setq delete-by-moving-to-trash t)
