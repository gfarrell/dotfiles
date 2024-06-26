;; -*- mode: elisp -*-

;; no splash screen
(setq inhibit-splash-screen t)

;; enable org mode
(require 'org)

;; automatically use org-mode for all .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
