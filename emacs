;; -*- Mode: Emacs-Lisp -*-

;;;
;;; Nick's .emacs File
;;;


;;; ===================
;;; Basic Configuration
;;; ===================

;;
;; (push-unique a l)
;;
;; Adds a to the front of list l, unless a is already a member of l. Uses
;; 'member for testing, which uses 'equal, FYI.
;;
(defun push-unique (a l)
  "Prepends A to list L, unless A is already a 'member of L."
  (if (and (listp l) (not (member a l)))
      (append (if (listp a)
		     a
		   (list a))
		 l)
    l))

;; 
;; Add some directories to the load path.
;;
(setq load-path
      (push-unique (expand-file-name "~/lib/emacs/lisp") load-path))

;;
;; Set a flag if we're running XEmacs
;;
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))


;;; ===========
;;; Keybindings
;;; ===========

(global-set-key "\C-h" 'delete-backward-char)  ; Control-H as backspace
(global-set-key [f1] 'help-for-help)           ; F1 calls up help
(global-set-key "\M-g" 'goto-line)             ; Esc-g calls goto-line


;;; ====================
;;; Additional Libraries
;;; ====================

;;
;; completer
;;
;; A partial-completion mechanism. For example, the command 
;; 'M-x byte-compile-and-load-file RET' can be abbreviated as 
;; 'M-x b-c-a RET'.
;;
(cond ((locate-library "completer")
       (message "completer...")
       (require 'completer)
))

;;
;; dired 
;;
;; Also, if possible load default-dir.el, which installs fancy
;; handling of the initial contents in the minibuffer when reading
;; file names.
;;
(cond ((locate-library "dired")
       (message "dired...")
       (cond ((locate-library "default-dir")
	      (message "default-dir...")
	      (require 'default-dir)
       ))
       (require 'dired)
))

;;
;; crypt
;;
;; Automagically handle compressed and/or encrypted files.
;;
(cond ((locate-library "crypt")
       (message "crypt...")
       (setq crypt-encryption-type 'pgp   ; default encryption mechanism
	     crypt-confirm-password t     ; make sure new passwords are correct
	     )
       (require 'crypt)
))

;;
;; font-lock
;;
(cond ((locate-library "font-lock")
       (message "font-lock...")
       (require 'font-lock)
       (setq font-lock-maximum-decoration t)
       (cond ((not running-xemacs)
             (setq global-font-lock-mode t)
       ))
))


;;; ====================
;;; Modes and File Types
;;; ====================

;;
;; Turn on auto-fill for all text modes
;;
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;
;; File extension recognition
;;
;; This adds additional extensions to be handled by specific modes.
;;
(cond ((locate-library "python-mode")
       (setq auto-mode-alist
	     (append '(("\\.py$"  . python-mode)
		       ("\\.pyw$" . python-mode))
		     auto-mode-alist))
       (setq interpreter-mode-alist (cons '("python" . python-mode)
					  interpreter-mode-alist))
       (autoload 'python-mode "python-mode" "Python editing mode." t)
       (add-hook 'python-mode-hook 
		 (lambda () (setq py-handle-triple-quoted-strings nil)))
))

;;
;; C mode indentation
;;
;; Change the indentation amount to 4 spaces instead of 2.
;; You have to do it in this complicated way because of the
;; strange way the cc-mode initializes the value of `c-basic-offset'.
;;
(add-hook 'c-mode-hook (lambda () (setq c-basic-offset 4)))


;;
;; Ruby stuff
;;
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist 
      (append '(("ruby" . ruby-mode)) interpreter-mode-alist))

;;
;; sh stuff
;;
(autoload 'sh-mode "sh-mode" "Major mode for editing (ba|z)sh scripts." t)
(setq auto-mode-alist (cons '("\\.sh$" . sh-mode) auto-mode-alist))
(setq interpreter-mode-alist 
      (append '(("bin/sh" . sh-mode)) interpreter-mode-alist)
      (append '(("bin/zsh" . sh-mode)) interpreter-mode-alist)
      (append '(("bin/bash" . sh-mode)) interpreter-mode-alist)
      )

;;; ==============
;;; Customizations
;;; ==============

;;
;; Some XEmacs-specific instructions
;; 
(cond (running-xemacs

       ;; Include mouse.el even if there's no window system
       (require 'mouse)

       ;; Set some default behaviors
       (setq find-file-use-truenames nil
	     find-file-compare-truenames t
	     minibuffer-confirm-incomplete t
	     complex-buffers-menu-p t
	     next-line-adds-newlines nil
	     mail-yank-prefix "> "
	     )
))

;;
;; Turn off the menu bar
;;
(cond ((functionp 'menu-bar-mode) 
       (menu-bar-mode 0)
))

;;
;; And the tool bar
(cond ((functionp 'tool-bar-mode)
       (tool-bar-mode 0)
))

;;
;; Set some preferences
;;
(custom-set-variables
 '(load-home-init-file t))

;;; ====================
;;; From emacs, to emacs
;;; ====================

(custom-set-faces)
