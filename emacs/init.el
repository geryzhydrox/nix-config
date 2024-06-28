(global-display-line-numbers-mode 1)
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
;; (set-face-attribute 'defaut nil :height 140)

(require 'doom-modeline)
(doom-modeline-mode 1)
(defun meow-append-eol ()
  (interactive)
  (end-of-line)
  (meow-insert))


(require 'transient)
(transient-define-prefix dispatch-goto-menu () "Documentation"
  [["Line"
    ("l" "End of line" end-of-line)
    ("h" "Beginning of line" beginning-of-line-text)
    ("m" "Mark line" meow-line)
    ("n" "Line number..." meow-goto-line)]
   ["Buffer"
    ("b" "Beginning of buffer" beginning-of-buffer)
    ("e" "End of buffer" end-of-buffer)]]
  ["At point"
   ("f" "File" ffap)
   ("d" "Definition" xref-find-definitions)])

(make-variable-buffer-local
 (defvar writing-mode nil
   "Toggle writing mode."))

(add-to-list 'minor-mode-alist '(writing-mode "writing"))
(defun writing-mode (&optional ARG)
  (interactive (list 'toggle))
  (setq writing-mode
	(if (eq ARG 'toggle)
		(not writing-mode)
	  (> ARG 0)))
  (if writing-mode
      `(,(olivetti-mode 1) ,(global-display-line-numbers-mode -1) ,(variable-pitch-mode 1))
      `(,(olivetti-mode -1) ,(global-display-line-numbers-mode 1) ,(variable-pitch-mode -1))))
	
	       
(defun meow-setup ()
  (defun meow-insert-bol ()
    (interactive)
    (beginning-of-line-text)
    (meow-insert))

  ;; (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-iso)
  ;; (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwertz)
  (meow-thing-register 'angle
		       '(pair (";") (":"))
		       '(pair (";") (":")))

  (setq meow-char-thing-table
	'((?r . round)
	  (?s . square)
	  (?c . curly)
	  (?a . angle)
	  (?g . string)
	  (?p . paragraph)
	  (?l . line)
	  (?b . buffer)
	  (?d . defun)))
  (setq meow-use-cursor-position-hack t)

  (meow-leader-define-key
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    '("-" . meow-keypad-describe-key)
    '("_" . meow-cheatsheet))

  (meow-normal-define-key
    ;; expansion
    '("0" . meow-expand-0)
    '("1" . meow-expand-1)
    '("2" . meow-expand-2)
    '("3" . meow-expand-3)
    '("4" . meow-expand-4)
    '("5" . meow-expand-5)
    '("6" . meow-expand-6)
    '("7" . meow-expand-7)
    '("8" . meow-expand-8)
    '("9" . meow-expand-9)
    '("ä" . meow-reverse)

    ;; movement
    '("k" . meow-prev)
    '("j" . meow-next)
    '("h" . meow-left)
    '("l" . meow-right)

    '("=" . indent-region)
    '("?" . isearch-backward)
    '("/" . isearch-forward)
    '("-" . negative-argument)
    '("n" . meow-search)
    ;; expansion
    '("K" . meow-prev-expand)
    '("J" . meow-next-expand)
    '("H" . meow-left-expand)
    '("L" . meow-right-expand)

    '("b" . meow-back-word)
    '("B" . meow-back-symbol)
    '("w" . meow-next-word)
    '("W" . meow-next-symbol)
    '("A" . meow-append-eol)
    '("I" . meow-insert-bol)

    '("m" . meow-mark-word)
    '("M" . meow-mark-symbol)
    '("g" . dispatch-goto-menu)
    '("v" . meow-block)
    '("r" . meow-join)
    '("e" . meow-grab)
    '("E" . meow-pop-grab)
    '("s" . meow-swap-grab)
    '("S" . meow-sync-grab)
    '("q" . meow-cancel-selection)
    '("Q" . meow-pop-selection)

    '("t" . meow-till)
    '("f" . meow-find)

    '("," . meow-beginning-of-thing)
    '("." . meow-end-of-thing)
    '(";" . meow-inner-of-thing)
    '(":" . meow-bounds-of-thing)

    ;; editing
    '("d" . meow-kill)
    '("c" . meow-change)
    '("x" . meow-delete)
    '("y" . meow-save)
    '("p" . meow-yank)
    '("P" . meow-yank-pop)

    '("i" . meow-insert)
    '("a" . meow-append)
    '("o" . meow-open-below)
    '("O" . meow-open-above)

    '("u" . undo-only)
    '("U" . undo-redo)

    '("z" . open-line)
    '("Z" . split-line)

    '("ü" . indent-rigidly-left-to-tab-stop)
    '("+" . indent-rigidly-right-to-tab-stop)

    ;; ignore escape
    '("<escape>" . ignore)))
(require 'meow)
(meow-setup)
(meow-global-mode 1)

;; (load-theme 'nord t)

;; (use-package base16-theme
;;   :ensure nil
;;   :load-path "site-lisp/base16-theme"
;;   :init
;;   (add-to-list 'custom-theme-load-path "/etc/nixos/emacs/themes")
;;   :config
;;   (load-theme 'base16-default-dark t))


(require 'base16-theme)
;; (setq base16-default-dark-theme-colors '(:base00 "#170c04"
;; 					 :base01 "#330000"
;; 					 :base02 "#2f1f13"
;; 					 :base03 "#b36624"
;; 					 :base04 "#eab15e"
;; 					 :base05 "#bb7950"
;; 					 :base06 "#e69532"
;; 					 :base07 "#c9bf28"
;; 					 :base08 "#ff8400"
;; 					 :base09 "#4d301c"
;; 					 :base0A "#4e4b03"
;; 					 :base0B "#b35900"
;; 					 :base0C "#eb9c24"
;; 					 :base0D "#bb6c3b"
;; 					 :base0E "#e65c17"
;; 					 :base0F "#c9a005"))

;; (load-theme 'base16-default-dark)
(require 'nerd-icons)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 
      ;; '("/home/gerald/Pictures/nix-snowflake-small.png" . "/home/gerald/Pictures/nix-snowflake-small.txt"))
      "/home/gerald/Pictures/nix-snowflake-small.txt")
(setq dashboard-center-content t)
(setq dashboard-display-icons-p t)
(setq dashboard-icon-type 'nerd-icons)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(dashboard-modify-heading-icons '((recents . "nf-oct-clock")
				  (bookmarks . "nf-oct-bookmark")
				  (agenda . "nf-oct-tasklist")))
(setq dashboard-item-shortcuts '((recents . "r")
				 (bookmarks . "m")
				 (agenda . "a")))
			       
(require 'use-package)
;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :diminish lsp-mode
;;   :hook
;;   (elixir-mode . lsp)
;;   :init
;;   (add-to-list 'exec-path "elixir-ls"))
(require 'eglot)

(require 'elixir-mode)
(require 'python-mode)
(require 'nix-mode)

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs `(elixir-mode "elixir-ls"))
(add-to-list 'eglot-server-programs `(python-mode "pylsp"))
(add-to-list 'eglot-server-programs `(nix-mode "nixd"))

;;(use-package yasnippet
;;  :hook (elixir-mode . yas-minor-mode))
;; (use-package flymake
;;  :hook (elixir-mode . flymake-mode))
(require 'olivetti)
(olivetti-set-width 85)
(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
(require 'sketch-mode) 
(pdf-loader-install)
(setq pdf-view-midnight-colors '("#D8DEE9" . "#2E3440"))
(with-eval-after-load 'org
  (require 'edraw-org))
(defun custom-edraw ()
  (interactive)
  (edraw-toggle-grid-visible (edraw-current-editor))
  (edraw-editor-set-background)) 
