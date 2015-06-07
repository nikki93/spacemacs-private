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
        magit
        diff-hl
        auctex
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
      (add-hook 'lisp-mode-hook 'fci-mode)
      (add-hook 'c-mode-common-hook 'fci-mode))))

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

(defun nikki93/init-flycheck ()
  (use-package flycheck
    :defer t
    :config
    (progn
      (define-key evil-normal-state-map "[e" 'flycheck-previous-error)
      (define-key evil-normal-state-map "]e" 'flycheck-next-error))))

(defun nikki93/init-magit ()
  (use-package magit
    :defer t
    :config
    (progn
      (setq magit-save-some-buffers nil)
      (define-key magit-status-mode-map (kbd "q") 'magit-mode-quit-window)
      (setq magit-status-buffer-switch-function 'switch-to-buffer))))

(defun nikki93/init-diff-hl ()
  (use-package diff-hl
    :init
    (global-diff-hl-mode)))

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

