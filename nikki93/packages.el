(setq nikki93-packages
      '(helm
        fill-column-indicator
        neotree
        elm-mode
        ;; auto-complete
        ;; company
        aggressive-indent
        paredit
        flycheck
        skewer-mode
        magit
        ;; diff-hl
        auctex
        shm
        glsl-mode
        gotham-theme))

(setq nikki93-excluded-packages
      '(git-gutter-fringe))

(defun nikki93/init-helm ()
  (use-package helm
    :defer t
    :config
    (setq helm-split-window-in-side-p t)))

(defun nikki93/init-fill-column-indicator ()
  (use-package fill-column-indicator
    :init
    (progn
      (add-hook 'prog-mode-hook 'fci-mode))
    :config
    (setq fci-rule-character ?\u2503)))

(defun nikki93/init-neotree ()
  (use-package neotree
    :init
    (progn
      (setq neo-window-width 23
            neo-theme 'arrow))))

;; (defun nikki93/init-auto-complete ()
;;   (use-package auto-complete
;;     :config
;;     (progn
;;       (setq ac-quick-help-delay 1)
;;       (define-key ac-complete-mode-map "\C-n" 'ac-next)
;;       (define-key ac-complete-mode-map "\C-p" 'ac-previous))))

;; (defun nikki93/init-company ()
;;   (use-package company
;;     :defer t
;;     :config
;;     (progn
;;       (global-company-mode 1)           ; set company-global-modes to taste
;;       (setq company-idle-delay 0.2
;;             company-selection-wrap-around t)
;;       (define-key company-active-map (kbd "\C-n") 'company-select-next)
;;       (define-key company-active-map (kbd "\C-p") 'company-select-previous)
;;       (define-key company-active-map (kbd "\C-j") 'company-select-next)
;;       (define-key company-active-map (kbd "\C-k") 'company-select-previous)
;;       (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
;;       (define-key company-active-map (kbd "<tab>") 'company-complete)
;;       (spacemacs|diminish company-mode " Ⓒ" " C"))))

(defun nikki93/init-aggressive-indent ()
  (use-package aggressive-indent
    :defer t
    :init
    (progn
      (add-hook 'slime-repl-mode-hook 'aggressive-indent-mode)
      (add-hook 'clojure-mode-hook 'aggressive-indent-mode)
      (add-hook 'cider-repl-mode-hook 'aggressive-indent-mode)
      (add-hook 'emacs-lisp-mode-hook 'aggressive-indent-mode)
      (add-hook 'lisp-mode-hook 'aggressive-indent-mode))))

(defun nikki93/init-paredit ()
  (use-package paredit
    :defer t
    :init
    (progn
      (add-hook 'slime-repl-mode-hook 'paredit-mode)
      (add-hook 'clojure-mode-hook 'paredit-mode)
      (add-hook 'cider-repl-mode-hook 'paredit-mode)
      (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
      (add-hook 'lisp-mode-hook 'paredit-mode)
      (add-hook 'racket-mode-hook 'paredit-mode)
      (add-hook 'racket-repl-mode-hook 'paredit-mode))
    :config
    (progn
      (define-key paredit-mode-map (kbd "M-{") 'paredit-wrap-curly)
      (define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)

      (add-hook 'slime-repl-mode-hook   ; Respect paredit deletion in repl
                (lambda ()
                  (define-key slime-repl-mode-map
                    (read-kbd-macro paredit-backward-delete-key)
                    nil)))

      ;; Mode-line icon
      (spacemacs|diminish paredit-mode " (Ⓟ)" " (P)"))))

(defun nikki93/init-flycheck ()
  (use-package flycheck
    :defer t
    :config
    (progn
      (define-key evil-normal-state-map "[e" 'flycheck-previous-error)
      (define-key evil-normal-state-map "]e" 'flycheck-next-error)

      ;; disable jshint since we prefer eslint checking
      (setq-default flycheck-disabled-checkers
                    (append flycheck-disabled-checkers
                            '(javascript-jshint)))

      ;; use eslint with web-mode for jsx files
      (flycheck-add-mode 'javascript-eslint 'web-mode)

      ;; disable json-jsonlist checking for json files
      (setq-default flycheck-disabled-checkers
                    (append flycheck-disabled-checkers
                            '(json-jsonlist))))))

(defun nikki93/init-skewer-mode ()
  (use-package skewer-mode
    :defer t
    :init
    (progn
      (add-hook 'js2-mode-hook 'skewer-mode)
      (add-hook 'css-mode-hook 'skewer-css-mode)
      (add-hook 'html-mode-hook 'skewer-html-mode))))

(defun nikki93/init-magit ()
  (use-package magit
    :defer t
    :config
    (progn
      (setq magit-save-some-buffers nil)
      (setq magit-status-buffer-switch-function 'switch-to-buffer))))

(defun auctex/init-auctex ()
  (use-package tex
    :defer t
    :config
    (progn
      (setq TeX-auto-save t)
      (setq TeX-parse-self t)
      (setq-default TeX-master t)

      (defun auctex/build ()
        (interactive)
        (if (buffer-modified-p)
            (progn
              (let ((TeX-save-query nil))
                (TeX-save-document (TeX-master-file)))
              (setq build-proc (TeX-command "LaTeX" 'TeX-master-file -1))
              (set-process-sentinel  build-proc  'auctex/build-sentinel))))

      (evil-leader/set-key-for-mode 'latex-mode
        "mb" 'auctex/build
        "mv" 'auctex/build-view))))

(defun nikki93/init-glsl-mode ())

(defun nikki93/init-elm-mode ())

(defun nikki93/init-shm ()
  (use-package shm
    :defer t
    :if haskell-enable-shm-support
    :init
    (add-hook 'haskell-mode-hook 'structured-haskell-mode)
    :config
    (progn
      (set-face-background 'shm-current-face "#eee8d5")
      (set-face-background 'shm-quarantine-face "lemonchiffon"))))

