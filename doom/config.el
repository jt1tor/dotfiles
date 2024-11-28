(use-package all-the-icons)

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")
(setq org-roam-directory (file-truename "~/notes/roam/"))

(setq org-roam-file-extensions '("org"))

(use-package org-roam
  :ensure t)

(use-package org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/notes/roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))

  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq doom-font (font-spec :family "Ubuntu Mono" :size 26)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 27)
      doom-symbol-font (font-spec :family "Noto Sans Symbols")
      doom-big-font (font-spec :family "Ubuntu Mono" :size 40))

(setq-default line-spacing .1)

;; org agenda stuff
(setq org-agenda-span 8
      org-agenda-start-day "-1d"
      org-agenda-skip-timestamp-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t)

(setq org-agenda-current-time-string "")
(setq org-agenda-time-grid '((daily) () "" ""))

(setq org-agenda-prefix-format '(
(agenda . " %?-2i %t ")
 (todo . "%i %-12:c")
 (tags . " %i %-12:c")
 (search . "%i %-12:c")))

;; org modern
(defun org-agenda-open-hook ()
;;   "Hook to be run when org-agenda is opened"
  (org-modern-agenda)
  (olivetti-mode))

(add-hook 'org-agenda-mode-hook 'org-agenda-open-hook)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;;(setq org-hide-emphasis-markers t)

(use-package org-bullets
  :config
   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(map! :leader "d" 'org-agenda-list)

;; (custom-set-faces
;;   '(org-level-1 ((t (:inherit outline-1 :height 1.06))))
;;   '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
;;   '(org-level-3 ((t (:inherit outline-3 :height 1.0)))))

;; TREEMACS
(map! :leader "k" 'treemacs)

(setq neo-smart-open t)

(with-eval-after-load 'treemacs
    (evil-define-key 'treemacs treemacs-mode-map (kbd "h") #'treemacs-root-up)
    (evil-define-key 'treemacs treemacs-mode-map (kbd "l") #'treemacs-root-down))
