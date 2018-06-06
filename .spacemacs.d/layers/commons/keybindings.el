;;quickrun
(spacemacs/set-leader-keys "oq" 'quickrun)
;;youdao
(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
;;hl-todo
(spacemacs/set-leader-keys "oh" 'hl-todo-occur)

;; make_header
(spacemacs/set-leader-keys "od" 'auto-make-header)

;; similar to tagbar or taglist in vim
(spacemacs/set-leader-keys "ob" 'sr-speedbar-toggle)

;; artist-mode
(spacemacs/set-leader-keys "oa" 'artist-mode)

;; solidity estimate gas
(spacemacs/set-leader-keys "og" 'solidity-estimate-gas-at-point)

;; remove ^M in emacs
(spacemacs/set-leader-keys "om" 'delete-carrage-returns)
(defun delete-carrage-returns ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))

;;insert-state use control+l to move right
(define-key evil-insert-state-map (kbd "C-l") 'right-char)

;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)
