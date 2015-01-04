(defun nikki93/toggle-window-fixed (&optional window)
  (interactive)
  (let ((window (or window (get-buffer-window (current-buffer)))))
    (cond
      ((and window-size-fixed (window-dedicated-p window))
       (set-window-dedicated-p window nil)
       (setq window-size-fixed nil)
       (message "Window '%s' not fixed" (current-buffer)))
      (t
        (set-window-dedicated-p window t)
        (setq window-size-fixed t)
        (message "Window '%s' fixed" (current-buffer))))))

(defun nikki93/live-coding-window-setup ()
  (interactive)
  (nikki93/toggle-window-fixed
    (split-window
      (split-window (get-buffer-window (current-buffer)) -117 'right)
      -47 'above)))

(defun nikki93/switch-fullscreen ()
  (interactive)
  (let* ((modes '(nil maximized fullboth fullwidth fullheight))
         (cm (cdr (assoc 'fullscreen (frame-parameters))))
         (next (cadr (member cm modes))))
    (modify-frame-parameters
      (selected-frame)
      (list (cons 'fullscreen next)))))

