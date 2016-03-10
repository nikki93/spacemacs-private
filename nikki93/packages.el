(setq nikki93-packages
      '(helm
        neotree
        elm-mode
        aggressive-indent
        paredit
        flycheck
        tern
        magit
        auctex
        glsl-mode
        darkroom
        ))

(defun nikki93/post-init-helm ()
  (use-package helm
    :defer t
    :config
    (setq helm-split-window-in-side-p t)))

(defun nikki93/post-init-neotree ()
  (use-package neotree
    :init
    (progn
      (setq neo-window-width 23
            neo-theme 'arrow))))

(defun nikki93/post-init-aggressive-indent ()
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

;; (defun nikki93/post-init-flycheck ()
;;   (use-package flycheck
;;     :defer t
;;     :config
;;     (progn
;;       (setq flycheck-display-errors-function 'flycheck-display-error-messages-unless-error-list))))

(defun nikki93/post-init-tern ()
  (use-package tern
    :defer t
    :config
    (progn
      (setq tern-command (append tern-command '("--no-port-file"))))))

(defun nikki93/post-init-magit ()
  (use-package magit
    :defer t
    :config
    (progn
      (setq magit-save-some-buffers nil)
      (setq magit-display-buffer-function
            (lambda (buffer)
              (display-buffer
               buffer (if (not (memq (with-current-buffer buffer major-mode)
                                     '(magit-process-mode
                                       magit-revision-mode
                                       magit-diff-mode
                                       magit-stash-mode)))
                          '(display-buffer-same-window)
                        nil))))

      ;; i use M-n to switch to window n, so unbind these
      (define-key magit-mode-map "\M-1" nil)
      (define-key magit-mode-map "\M-2" nil)
      (define-key magit-mode-map "\M-3" nil)
      (define-key magit-mode-map "\M-4" nil))))

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

(defun nikki93/init-darkroom ())

