;; -----------------------------------------------------------------------------
;; Aerial Emacs
;; Author: Nicolas P. Rougier
;; Licence: GNU GPL v3
;; -----------------------------------------------------------------------------

;; ----------------------------------------------------------------------------
;; Initialization
;; ----------------------------------------------------------------------------
(setq inhibit-startup-message t)   ;; No startup page
(setq initial-scratch-message nil) ;; No *scratch* buffer message
(menu-bar-mode 0)                  ;; No menubar
(tool-bar-mode 0)                  ;; No toolbar
(tooltip-mode  0)                  ;; No tooltip
(scroll-bar-mode 0)                ;; Noe scrollbar
(blink-cursor-mode 0)              ;; No blinking cursor
(setq pop-up-windows nil)          ;; No popup windows


;; ----------------------------------------------------------------------------
;; Geometry
;; ----------------------------------------------------------------------------
;; Fringe on left and right: 8 pixels
(fringe-mode '(8 . 8))

;; Internal border: 32 pixels
(modify-frame-parameters (selected-frame)
                         '((internal-border-width . 32)))
;; Default frame size and border
(setq default-frame-alist (append (list
                           '(width . 88) '(height .  42)
                           '(top   . 50) '(left   . 250)
                           '(internal-border-width . 32))
                           default-frame-alist))

(setq-default frame-title-format "%b")
(setq         frame-title-format "%b")

;; ----------------------------------------------------------------------------
;; Linum & hlinum
;; ----------------------------------------------------------------------------
(defun fullpath-relative-to-current-file (file-relative-path)
  (concat (file-name-directory
	   (or load-file-name buffer-file-name))
	  file-relative-path))
(add-to-list 'load-path (fullpath-relative-to-current-file "."))

(require 'linum)                   ;; Line number
(require 'hlinum)                  ;; Highlight current line in linum
(setq linum-format "  %3d  ")      ;; Lium format

(dolist (hook (list 'emacs-lisp-mode-hook
                    'python-mode-hook
                    'tex-mode-hook
                    'latex-mode-hook
                    'c-mode-hook
                    'text-mode-hook
                    'rst-mode-hook
                    'c++-mode-hook))
   (add-hook hook 'linum-mode))


;; ----------------------------------------------------------------------------
;; Headerline
;; ----------------------------------------------------------------------------
(defun mode-line-fill (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(setq-default header-line-format (list
   " "
   'mode-line-mule-info
   'mode-line-modified
   "  "
   'mode-line-buffer-identification
   'mode-line-modes
   " -- "
   `(vc-mode vc-mode)

   ;; File read-only
   '(:eval (if buffer-read-only
               (list (mode-line-fill 'nil 13)
                     (propertize " [read-only] " 'face 'header-line-grey))))

   ;; File modified
   '(:eval (if (buffer-modified-p)
               (list (mode-line-fill 'nil 12)
                     (propertize " [modified] " 'face 'header-line-red))
             (list (mode-line-fill 'nil 9)
                   (propertize "%4l:%3c " 'face 'header-line))))
   ))
(setq-default mode-line-format "")


;; ----------------------------------------------------------------------------
;; Font
;; ----------------------------------------------------------------------------
(set-frame-font "Source Code Pro Light 14")
(add-to-list 'default-frame-alist
             '(font . "Source Code Pro Light 14"))

;; ----------------------------------------------------------------------------
;; Colors
;; -----------------------------------------------------------------------------
(setq frame-background-mode 'light)
(set-foreground-color "#000000")
(set-background-color "#ffffff")

(set-face-attribute 'bold nil
                    :weight 'regular)

(make-face 'header-line-grey)
(set-face-attribute 'header-line-grey nil
                    :weight 'medium
                    :foreground "#ffffff"
                    :background "#999999"
                    :box '(:line-width 1 :color "#999999"))
(make-face 'header-line-red)
(set-face-attribute 'header-line-red nil
                    :weight 'medium
                    :foreground "white"
                    :background "#dd7777"
                    :box '(:line-width 1 :color "#dd7777"))

(set-face-attribute 'mode-line nil
                    :height 10
                    :background "#999"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :height 10
                    :background "#999"
                    :box nil)
(set-face-attribute 'header-line nil
                    :inherit nil
                    :foreground "white"
                    :background "#000000"
                    :box '(:line-width 3 :color "#000000"))

(set-face-attribute 'fringe  nil
                    :inherit nil
                    :background "#ffffff")
(set-face-attribute 'show-paren-match nil
                    :bold t
                    :background "#dddddd")

(set-face-attribute 'linum nil
                   :foreground "#cccccc"
                   :background "#f9f9f9")
(set-face-attribute 'linum-highlight-face nil
                   :weight 'medium
                   :foreground "#555555"
                   :background "#f0f0f0")

(set-face-attribute 'highlight nil
                    :background "#f5f5ff")
(set-face-attribute 'font-lock-comment-face nil
                    :foreground "#8c878f")
(set-face-attribute 'font-lock-constant-face nil
                    :foreground "#3b5bb5")
(set-face-attribute 'font-lock-string-face nil
                    :foreground "#0078ff")
(set-face-attribute 'font-lock-function-name-face nil
                    :foreground "#3b5bb5")
(set-face-attribute 'font-lock-variable-name-face nil
                    :foreground "black")
(set-face-attribute 'font-lock-type-face nil
                    :foreground "#3b5bb5")
(set-face-attribute 'font-lock-keyword-face nil
                    :foreground "#ff7800")
(set-face-attribute 'region nil
                    :stipple nil
                    :background "#ffffcc")
(set-face-attribute 'isearch nil
                    :foreground "#000000"
                    :background "#ffff00")
(set-face-attribute 'lazy-highlight nil
                    :background "paleturquoise")
