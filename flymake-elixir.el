;;; flymake-elixir.el --- a flymake handler for elixir-mode .ex files
;;
;;; author: sylvain benner based on flymake-easy from steve purcell
;;; url: https://github.com/syl20bnr/flymake-elixir
;; version: 0.1
;;; x-original-version: dev
;;; package-requires: ((flymake-easy "0.1"))
;;;
;;; commentary:
;; usage:
;;   (require 'flymake-elixir)
;;   (add-hook 'elixir-mode-hook 'flymake-elixir-load)
;;
;; uses flymake-easy, from https://github.com/purcell/flymake-easy

;;; code:
(require 'flymake-easy)

(defconst flymake-elixir-err-line-patterns
  '(("^\\(** (.*) \\)?\\(.*\.ex\\):\\([0-9]+\\): \\(.*\\)$" 2 3 nil 4)))
(defconst flymake-elixir-warn-regex
  "\\(.*unused$\\)")

(defvar flymake-elixir-executable "elixirc"
  "The elixir executable to use for syntax checking.")

;; Invoke elixir with '-c' to get syntax checking
(defun flymake-elixir-command (filename)
  "Construct a command that flymake can use to check elixir source."
  (list flymake-elixir-executable
        "--ignore-module-conflict"
        "+warn_obsolete_guard"
        "+warn_unused_import"
        "+warn_shadow_vars"
        "+warn_export_vars"
        "+strong_validation"
        "+report"
        filename))

;;;###autoload
(defun flymake-elixir-load ()
  "Configure flymake mode to check the current buffer's elixir syntax."
  (interactive)
  (flymake-easy-load 'flymake-elixir-command
                     flymake-elixir-err-line-patterns
                     'tempdir
                     "ex"
                     flymake-elixir-warn-regex))

(provide 'flymake-elixir)
;;; flymake-elixir.el ends here
