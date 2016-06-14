(add-to-list 'load-path "~/.emacs.d/code/web-mode/web-mode")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;A specific engine can be forced with web-mode-engines-alist.
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
      )
;;The var web-mode-content-types-alist can be used to associate a file path with a content type
(add-to-list 'auto-mode-alist '("\\.api\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/some/react/path/.*\\.js[x]?\\'" . web-mode))

(setq web-mode-content-types-alist
  '(("json" . "/some/path/.*\\.api\\'")
    ("xml"  . "/other/path/.*\\.api\\'")
    ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))
;;he first customisations can be put in a hook like this
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
;;HTML element offset indentation
(setq web-mode-markup-indent-offset 2)
;;;CSS offset indentation
(setq web-mode-css-indent-offset 2)
;;Script/code offset indentation (for JavaScript, Java, PHP, Ruby, VBScript, Python, etc.)
(setq web-mode-code-indent-offset 2)
;;You can disable arguments|concatenation|calls lineup with
(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
;;For <style> parts
(setq web-mode-style-padding 1)
;;For <script> parts
(setq web-mode-script-padding 1)
;;For multi-line blocks
(setq web-mode-block-padding 0)

;;Change the shortcut for element navigation
(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
;;Snippets
;;Add a snippet
(setq web-mode-extra-snippets
      '(("erb" . (("toto" . ("<% toto | %>\n\n<% end %>"))))
        ("php" . (("dowhile" . ("<?php do { ?>\n\n<?php } while (|); ?>"))
                  ("debug" . ("<?php error_log(__LINE__); ?>"))))
       ))
;;Add auto-pair
(setq web-mode-extra-auto-pairs
      '(("erb"  . (("beg" "end")))
        ("php"  . (("beg" "end")
                   ("beg" "end")))
       ))
;;cSS colorization
(setq web-mode-enable-css-colorization t)
;;Block face: can be used to set blocks background and default foreground (see web-mode-block-face)
(setq web-mode-enable-block-face t)
;;Part face: can be used to set parts background and default foreground (see web-mode-script-face and web-mode-style-face which inheritate from web-mode-part-face)
(setq web-mode-enable-part-face t)
;;Comment keywords (see web-mode-comment-keyword-face)
(setq web-mode-enable-comment-keywords t)
;;Heredoc (cf. PHP strings) fontification (when the identifier is <<<EOTHTML or <<<EOTJAVASCRIPT)
(setq web-mode-enable-heredoc-fontification t)
;;Add constants
;;;Also available: web-mode-extra-keywords, web-mode-extra-types
;;Current element / column highlight
;;Highlight current HTML element (see web-mode-current-element-highlight-face)
(setq web-mode-enable-current-element-highlight t)
;;You can also highlight the current column with
(setq web-mode-enable-current-column-highlight t)

;;If you have auto-complete installed, you can set up per-language ac-sources with web-mode-ac-sources-alist:

(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
;;To find a language's name, run the function web-mode-language-at-pos while in a block of it.
;;All hooks in web-mode-before-auto-complete-hooks are run just before auto-completion starts. This is useful for adapting ac-sources meant for a single language to web-mode, like ac-source-yasnippet.
;;Here is a sample config for editing PHP templates, using php-auto-yasnippets, emmet-mode, and ac-emmet:
(setq web-mode-ac-sources-alist
  '(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
    ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
    ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
                   (yas-activate-extra-mode 'php-mode)
                 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil)))))



;;end
(provide 'init-web-mode)