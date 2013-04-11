;; 言語設定
(set-language-environment 'Japanese)
;; 文字コード設定
(prefer-coding-system 'utf-8)
;; パスの設定
(setq load-path (cons "~/.emacs.d/elisp" load-path))
;; 対応する括弧の強調
(show-paren-mode t)
;; 外部デバイスとクリップボードを共有
(setq x-select-enable-clipboard t)
;; 改行でオートインデント
(global-set-key "\C-m" 'newline-and-indent)
;; BSやDel、文字入力でリージョン内の文字を削除
(delete-selection-mode t)
;; C-k １回で行全体を削除する
(setq kill-whole-line t)
;; M-jを入力すると対応するカッコに飛ぶ
(global-set-key (kbd "M-j") 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
;; Ctrl + 1でgoto line
(define-key global-map (kbd "C-1") 'goto-line)
;; Ctrl + zでundo
(define-key global-map (kbd "C-z") 'undo)
;; Ctrl + yでredo
(when (require 'redo nil t)
  (define-key global-map [?\C-y] 'redo))
;; Ctrl + fを検索に
(global-set-key "\C-f" 'isearch-forward)
;; コピー
(keyboard-translate ?\C-c ?\C-e)
(keyboard-translate ?\C-e ?\C-c)
(define-key global-map (kbd "C-e") 'kill-ring-save)
;; ペースト
(define-key global-map (kbd "C-v") 'yank)
;; 単語の前に
(define-key global-map (kbd "M-r") 'backward-word)
;; 単語の後に
(define-key global-map (kbd "M-y") 'forward-word)
;; 交換はM-t
;; 画面を下に
(define-key global-map (kbd "C-.") 'scroll-up)
;; 画面を上に
(define-key global-map (kbd "C-,") 'scroll-down)
;; 行の最後に
(define-key global-map (kbd "C-q") 'move-end-of-line)
;; 行の前にはデフォのC-aをそのまま採用
;; 自動括弧
(require 'flex-autopair)
(flex-autopair-mode 1)
;; コンパイル
(global-set-key "\C-p" 'compile)
;; シェル
(define-key global-map (kbd "C-o") 'shell)
;; shell-modeで矢印キーの上下でコマンド履歴を表示
(setq shell-mode-hook
      (function (lambda ()
                  (define-key shell-mode-map [up] 'comint-previous-input)
                  (define-key shell-mode-map [down] 'comint-next-input))))
;; スクロールバーを消す
(set-scroll-bar-mode 'nil)
;; 行番号
(require 'wb-line-number)
(wb-line-number-toggle)
;; 起動画面を表示しない
(setq inhibit-splash-screen t)
;; ツールバー非表示
(tool-bar-mode -1)
;; C-Ret で矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
;; color設定
(require 'color-theme)
(color-theme-initialize)
(color-theme-billw)
;; フレームの透明度
(set-frame-parameter (selected-frame) 'alpha '(0.85))
;; モードラインに行番号表示
(line-number-mode t)
;; モードラインに列番号表示
(column-number-mode t)
;; C-Ret で矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil)
;; anything --------------------------------------
;; 
(require 'anything)
(require 'anything-startup)
(require 'anything-config)
(require 'recentf)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
(define-key global-map (kbd "C-^") 'anything) ;Ctrl-^で起動
;; 縦横切り替え
(defun my-anything-toggle-resplit-window ()
  (interactive)
  (when (anything-window)
    (save-selected-window
      (select-window (anything-window))
      (let ((before-height (window-height)))
        (delete-other-windows)
        (switch-to-buffer anything-current-buffer)
        (if (= (window-height) before-height)
            (split-window-vertically)
          (split-window-horizontally)))
      (select-window (next-window))
      (switch-to-buffer anything-buffer))))

(define-key anything-map "\C-j" 'my-anything-toggle-resplit-window)
;;バッファの一覧を取得
;;anything-c-source-buffers
;;バッファにマッチしなかった場合にバッファを作成
;;anything-c-source-buffer-not-found
;;カレントディレクトリにあるファイル一覧
;;anything-c-source-files-in-current-dir
;;最近開いたファイル一覧
;;anything-c-source-recentf
(setq recentf-max-saved-items 3000)
(recentf-mode 1)

(defun describe-plist (symbol)
  "Display SYMBOL's property list."
  (interactive
   (let ((sym (variable-at-point t))
         (enable-recursive-minibuffers t)
         str)
     (when (or (not (symbolp sym))
               (not (symbol-plist sym)))
       (setq sym nil))
     (setq str (completing-read
                (if sym
                    (format
                     "Describe property list (default %s): " sym)
                  "Describe property list: ")
                obarray
                'symbol-plist
                t nil nil
                (when sym (symbol-name sym))))
     (list (if (equal str "")
               sym (intern str)))))
  (unless (symbol-plist symbol)
    (error "Symbol %s has no property list" symbol))
  (require 'apropos)
  (apropos-describe-plist symbol))

(define-key help-map "P" 'describe-plist)
