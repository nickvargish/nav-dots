
;; ============
;; GNUS SECTION
;; ============

;;; Autoload the appropriate gnus functions
;(autoload 'gnus            "gnus-hide"  "UseNet Gnus" t)
;(autoload 'gnus-batch-kill "gnus"       "Batch kill files" t)

;;; Basic setup - distributions, save files, etc.
(setq gnus-article-save-directory "~/news/")
(setq gnus-auto-select-next nil)
(setq gnus-auto-select-first nil)
(setq gnus-default-article-saver 'gnus-Subject-save-in-mail)
(setq gnus-distribution-list '("local" "world" "md" "va" "dc"))
(setq gnus-Info-directory "/usr/local/info/")
(setq gnus-kill-files-directory "~/news/SCORE/")

(setq gnus-novice-user nil)
; (setq  gnus-signature-file nil)
(setq gnus-use-long-file-name t)
(setq gnus-your-domain "bandersnatch.org")
(setq gnus-your-organization "Unix Guy for Hire")
(setq message-default-news-headers
      "From: Nick Vargish <nav+posts@bandersnatch.org>\n")

(setq gnus-use-demon t)

(add-hook 'nntp-server-opened-hook 'nntp-send-authinfo)

(setq gnus-nntp-server "wdc.news.speakeasy.net")
(setq gnus-nntp-service "nntp")
(setq gnus-read-active-file "some")
;(setq gnus-nov-is-evil t)

;(setq gnus-use-nocem t)
;(setq gnus-nocem-directory "~/news/NoCeM/")

;;Make gnus load netscape when you click on an url
(setq gnus-button-url 'gnus-netscape-open-url)
(setq browse-url-browser-function 'browse-url-netscape)

(setq gnus-use-bbdb t)
(setq gnus-use-tm t)
(setq gnus-use-mailcrypt t)
(setq gnus-use-adaptive-scoring nil)

(setq gnus-thread-sort-functions '(gnus-thread-sort-by-number
				   gnus-thread-sort-by-subject
				   gnus-thread-sort-by-total-score))

;; Try to disable courtesy copies.
(setq gnus-auto-mail-to-author nil)
(setq message-insert-courtesy-copy nil)

;;; Hooks
(setq gnus-startup-hook
      ;;; Make sure we have all the extra stuff we want
      '(lambda ()
         ;(define-key gnus-Subject-mode-map "\C-k" 'gnus-Subject-auto-kill)
         ; (require 'gnus-hide)   ;;; Hide sigs/quoted parts of articles
	 (require 'gnus-demon)    ;;; yay demons
	 ;(gnus-demon-add-handler 'gnus-demon-scan-nocem 45 t)
         ;(require 'gnus-mark)  	  ;;; Act on multiple articles
	 ;(bbdb-insinuate-gnus)    ;;; make bbdb available
	 ))

;(add-hook 'gnus-summary-mode-hook 'mc-install-read-mode)
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
;(add-hook 'news-reply-mode-hook 'mc-install-write-mode)

;(setq gnus-secondary-select-methods
;      '((nnfolder "private")))
;(setq nnfolder-directory "~/mail/") 
;(setq nnmail-spool-file "~/Mailbox")
;(setq nnmail-split-methods
;      '(("Qmail" "^\\(Cc:\\|To:\\).*djb-qmail")
;	("mail.crazy" "^Subject:.*die\\|^Organization:.*flabby")
;	("Inbox" "")))
;(setq nnfolder-get-new-mail t)

;(setq gnus-mail-save-name
;      ;;; Automatically generate a mail file for certain newsgroups
;      ;;; Just do a ((string-match "criteria" newsgroup) "FOLDERNAME")
;      ;;; inside the cond statement to add your own.
;      '(lambda (newsgroup headers &optional last-name)
;         (cond
;          ((string-match "netrek" newsgroup) "~/Mail/netrek")
;          ((string-match "humor" newsgroup) "~/Mail/humor")
;          ((string-match "computer" newsgroup) "~/Mail/computers")
;          ((string-match "emacs" newsgroup) "~/Mail/emacs")
;          ((string-match "source" newsgroup) "~/Mail/sources")
;          (t "~/Mail/misc"))))

;(setq gnus-Article-prepare-hook
;    ;;; automatcially hide signatures, quotes, and simplify some reference
;    ;;; fields
;      '(gnus-Article-hide-quote
;        gnus-Article-hide-sig
;        gnus-Article-simplify-references))

