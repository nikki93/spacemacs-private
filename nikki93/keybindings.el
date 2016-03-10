(define-key global-map (kbd "C-s") 'save-buffer)
(define-key global-map (kbd "M-s") 'save-buffer)
(define-key global-map (kbd "M-`") 'delete-window)

(define-key evil-normal-state-map ",r" 'nikki93/cgame-scratch)
(define-key evil-visual-state-map ",r" 'nikki93/cgame-scratch)

(define-key evil-normal-state-map ",e" 'nikki93/exponent-scratch)
(define-key evil-visual-state-map ",e" 'nikki93/exponent-scratch)
