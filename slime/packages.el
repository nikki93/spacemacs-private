(defvar slime-packages
  '(slime
    ac-slime
    ;; slime-company
    paredit)
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defun slime/init-ac-slime ()
  (use-package ac-slime
    :defer t
    :init
    (progn
      (add-hook 'slime-mode-hook (lambda () (set-up-slime-ac t)))
      (add-hook 'slime-mode-hook (lambda () (auto-complete-mode)))
      (add-hook 'slime-repl-mode-hook (lambda () (set-up-slime-ac t)))
      (add-hook 'slime-repl-mode-hook (lambda () (auto-complete-mode)))
      (eval-after-load "auto-complete"
        '(add-to-list 'ac-modes 'slime-repl-mode)))))

(defun slime/init-slime ()
  (use-package slime
    :defer t
    :init
    (progn
      (evil-leader/set-key-for-mode 'lisp-mode "mj" 'slime))
    :config
    (progn
      ;; Slime
      (setq inferior-lisp-program "sbcl")
      (require 'slime-autoloads)
      (setq slime-contribs '(slime-fancy
                             slime-fuzzy
                             ;; slime-company
                             slime-highlight-edits
                             slime-asdf)
            slime-repl-return-behaviour :send-only-if-after-complete
            slime-inhibit-pipelining nil)
      (slime-setup)

      ;; Paredit
      (add-hook 'slime-repl-mode-hook 'paredit-mode)

      ;; Mode-line icon
      (spacemacs|diminish slime-mode " Ⓛ" " SL")

      ;; Evil keys
      (evil-leader/set-key-for-mode 'lisp-mode
        ;; Evaluation
        "mes" 'slime-eval-last-expression
        "mee" 'slime-eval-defun
        "me:" 'slime-interactive-eval
        "mer" 'slime-eval-region
        "mep" 'slime-pprint-eval-last-expression
        "meE" 'slime-edit-value
        "mu"  'slime-undefine-function
        "meb" 'slime-eval-buffer

        ;; Compilation
        "mcc" 'slime-compile-defun
        "mcf" 'slime-compile-and-load-file
        "mck" 'slime-compile-file
        "mcl" 'slime-load-file
        "mcr" 'slime-compile-region
        "mn"  'slime-next-note
        "mN"  'slime-previous-note

        ;; Goto
        "mg"  'slime-edit-definition
        "mG"  'slime-pop-find-definition-stack

        ;; Documentation
        "mhd" 'slime-describe-symbol
        "mhf" 'slime-describe-function
        "mhA" 'slime-apropos
        "mhz" 'slime-apropos-all
        "mhp" 'slime-apropos-package
        "mhh" 'slime-hyperspec-lookup
        "mh~" 'hyperspec-lookup-format
        "mh#" 'hyperspec-lookup-reader-macro

        ;; Cross-reference
        "mwc" 'slime-who-calls
        "mww" 'slime-calls-who
        "mwr" 'slime-who-references
        "mwb" 'slime-who-binds
        "mws" 'slime-who-sets
        "mwm" 'slime-who-macroexpands
        "mwg" 'slime-who-specializes    ; 'g' for 'generic'
        "mw<" 'slime-list-callers
        "mw>" 'slime-list-callees

        ;; Macro-expansion
        "mmm" 'slime-macroexpand-1
        "mmM" 'slime-macroexpand-all
        "mmc" 'slime-compiler-macroexpand-1

        ;; Disassembly/tracing
        "md"  'slime-disassemble-symbol
        "mt"  'slime-toggle-trace-fdefinition
        "mT"  'slime-untrace-all

        ;; Profiling
        "mpu" 'slime-unprofile-all
        "mpr" 'slime-profile-report
        "mpR" 'slime-profile-reset
        "mpf" 'slime-toggle-profile-fdefinition
        "mpp" 'slime-profile-package
        "mps" 'slime-profile-by-substring))))

(defun slime/init-paredit ()
  (use-package paredit
    :defer t
    :init
    (progn
      (add-hook 'lisp-mode-hook 'paredit-mode))
    :config
    (progn
      (add-hook 'slime-repl-mode-hook   ; Respect paredit deletion in repl
                (lambda ()
                  (define-key slime-repl-mode-map
                    (read-kbd-macro paredit-backward-delete-key)
                    nil)))

      ;; Mode-line icon
      (spacemacs|diminish paredit-mode " (Ⓟ)" " (P)"))))

