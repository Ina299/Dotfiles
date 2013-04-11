;;; increment.el - increment or decrement a number in the buffer
;;; Copyright (C) 1998
;;;		Hirotaka Yamamoto <ymmt@is.s.u-tokyo.ac.jp>,
;;;		Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;;; Commentary:

;; These functions increment or decrement a number in the buffer
;; at your position.  Useful with attached key-binding.

;;; ChangeLog:
;; May 17 1998  Cristian Ionescu-Idbohrn
;;		Modified to accept `+' and `-' characters
;;		as part of the number.
;;		Replaced `char-before' occurences with
;;		the corresponding `char-after' expressions,
;;		to make it work with Emacs 19.36 too, where
;;		`char-before' is undefined.
;; May 05 1998	Hirotaka Yamamoto
;;		created.

;;; Code:

(require 'cl)

(defun increment (n)
  "Increment a number at point.
With prefix-argument, add it to the number."
  (interactive "p")
  (save-excursion
    (let ((val (char-after (1- (point))))
          start)
      (while (and (not (bobp))
                  (or (= 43 val)          ;; a `+' char
                      (= 45 val)          ;; a `-' char
                      (and (>= val 48)    ;; a `0' char
                           (<= val 57)))) ;; a `9' char
        (backward-char)
        (setq val (char-after (1- (point)))))
      (setq start (point))
      (setq val (char-after (point)))
      (while (and (not (eobp))
                  (or (= 43 val)          ;; a `+' char
                      (= 45 val)          ;; a `-' char
                      (and (>= val 48)    ;; a `0' char
                           (<= val 57)))) ;; a `9' char
        (forward-char)
        (setq val (char-after (point))))
      (setq val (buffer-substring start (point)))
      (if (zerop (length val))
          (error "No number at this point.")
        (delete-region start (point))
        (insert (int-to-string (+ (string-to-int val) n)))))))

(defun decrement (n)
  "Decrement a number at point.
With prefix-argument, subtract it from the number."
  (interactive "p")
  (increment (- n)))

(global-set-key (read-kbd-macro "M-<kp-add>") 'increment)
(global-set-key (read-kbd-macro "M-<kp-subtract>") 'decrement)

(provide 'increment)

;;; end of `increment.el'
