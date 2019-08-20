(defun org-tagging/org-set-tags (x)
  """ Toggle Selected Tags """
  (let* ((visual-candidates (helm-marked-candidates))
         (actual-candidates (mapcar (lambda (x) (cadr (assoc x org-tagging/org-tagging-candidates-names))) visual-candidates))
         (prior-point 1)
         (end-line(cdr org-tagging/org-tagging-region))
         (current-tags '())
         (add-func (lambda (candidate)
                     (if (not (-contains? current-tags candidate))
                         (push candidate current-tags)
                       (setq current-tags (remove candidate current-tags))
                       ))))
    (save-excursion
      (goto-char (car org-tagging/org-tagging-region))
      (setq prior-point (- (point) 1))
      (while (and (/= prior-point (point)) (< (line-number-at-pos (point)) end-line))
        (progn (setq current-tags (org-get-tags nil t)
                     prior-point (point))
               (mapc add-func actual-candidates)
               (org-set-tags current-tags)
               (org-forward-heading-same-level 1)
               )))))

(defun org-tagging/org-set-new-tag (x)
  (save-excursion
    (goto-char (car org-tagging/org-tagging-region))
    (let ((prior-point (- (point) 1))
          (end-line(cdr org-tagging/org-tagging-region)))
      (while (and (/= prior-point (point)) (< (line-number-at-pos (point)) end-line))
        (setq prior-point (point))
        (let* ((current-tags (org-get-tags nil t)))
          (if (not (-contains? current-tags x))
              (push x current-tags))
          (org-set-tags current-tags)
          (org-forward-heading-same-level 1)
          )))))

(defun org-tagging/sort-candidates (ap bp)
  """ Sort candidates by colour then lexicographically """
  (let* ((a (car ap))
         (b (car bp))
         (aprop (get-text-property 0 'font-lock-face a))
         (bprop (get-text-property 0 'font-lock-face b))
         (lookup (lambda (x) (gethash (cadr x) org-tagging/org-tagging-candidate-counts))))
    (cond
     ((and aprop bprop (> (funcall lookup ap) (funcall lookup bp))) t)
     ((and aprop (not bprop)) t)
     ((and (not aprop) (not bprop) (> (funcall lookup ap) (funcall lookup bp))))
     )))

(defun org-tagging/org-tagging-candidates ()
  """ Given Candidates, colour them if they are assigned, then sort them  """
  (let* ((cand-counts (org-tagging/org-count-buffer-tags)))
    (if (not (hash-table-empty-p cand-counts))
        (let* ((cand-keys (hash-table-keys cand-counts))
               (cand-vals (hash-table-values cand-counts))
               (cand-pairs (-zip cand-keys cand-vals))
               (maxTagLength (apply 'max (mapcar 'length cand-keys)))
               (maxTagAmount (apply 'max cand-vals))
               (bar-keys (org-tagging/make-bar-chart cand-pairs maxTagLength maxTagAmount))
               (display-pairs (-zip bar-keys cand-keys))
               (current-tags (org-get-tags nil t))
               (propertied-tags (map 'list (lambda (candidate)
                                             (let ((candString (car candidate)))
                                               (if (-contains? current-tags (cdr candidate))
                                                   (progn (put-text-property 0 (length candString)
                                                                             'font-lock-face
                                                                             'rainbow-delimiters-depth-1-face
                                                                             candString)))
                                               `(,candString ,(cdr candidate)))) display-pairs))
               )
          (setq org-tagging/org-tagging-candidate-counts cand-counts)
          (setq org-tagging/org-tagging-candidates-names (sort propertied-tags 'org-tagging/sort-candidates))
          )
      '()
      ))
  )

(defun org-tagging/make-bar-chart (data maxTagLength maxTagAmnt)
    (let* ((maxTagStrLen (length (number-to-string maxTagAmnt)))
           (maxTagLength-bounded (min 40 maxTagLength))
           (max-column (- fill-column (+ 3 maxTagLength-bounded maxTagStrLen 3 3)))
           (bar-div (/ (float max-column) maxTagAmnt)))
      (mapcar (lambda (x)
                (let* ((tag (car x))
                       (tag-len (length tag))
                       (tag-cut-len (min tag-len (- maxTagLength-bounded 3)))
                       (tag-truncated-p (> tag-len (- maxTagLength-bounded 3)))
                       (tag-substr (string-join `(,(substring tag nil tag-cut-len)
                                                  ,(if tag-truncated-p "..."))))
                       (tag-final-len (length tag-substr))
                       (amount (cdr x))
                       (amount-str (number-to-string amount))
                       (sep-offset (- (+ 3 maxTagLength-bounded) tag-final-len))
                       (amount-offset (- maxTagStrLen (length amount-str)))
                       (bar-len (ceiling (* bar-div amount)))
                       )
                  (string-join `(,tag-substr
                                 ,(make-string sep-offset ?\ )
                                 " : "
                                 ,amount-str
                                 ,(make-string amount-offset ?\ )
                                 " : "
                                 ,(make-string bar-len ?=)
                                 ;; "\n"
                                 )))) data)))

(defun org-tagging/org-count-buffer-tags ()
    (save-excursion ;;store where you are in the current
      (goto-char (point-min))
      ;;where to store tags:
      (let ((tag-set (make-hash-table :test 'equal)))
        ;;match all
        (while (not (eq nil (re-search-forward ":\\([[:graph:]]+\\):\\(\.\.\.\\)?\$" nil t)))
          ;;split tags into list
          (let* ((tags (split-string (match-string-no-properties 0) ":" t ":"))
                 (filtered (seq-filter (lambda (x) (not (or (string-equal x "PROPERTIES")
                                                            (string-equal x "END")
                                                            (string-equal x "DATE")
                                                            ))) tags)))
            ;;increment counts
            (mapc (lambda (x) (puthash x (+ 1 (gethash x tag-set 0)) tag-set)) filtered)
            )
          )
        tag-set
        )
      )
    )

(defun org-tagging/tag-occurrences-in-open-buffers()
    """ retrieve all tags in all open buffers, print to a temporary buffer """
    (interactive)
    (let* ((allbuffers (buffer-list))
           (alltags (make-hash-table :test 'equal))
           (hashPairs nil)
           (sorted '())
           (maxTagLength 0)
           (maxTagAmnt 0))
      (map 'list (lambda (bufname)
                   ;; TODO quit on not an org file
                   (with-current-buffer bufname
                     (let ((buftags (org-tagging/org-count-buffer-tags)))
                       (maphash (lambda (k v)
                                  (puthash k (+ v (gethash k alltags 0)) alltags))
                                buftags)
                       ))) allbuffers)
      (setq hashPairs (-zip (hash-table-keys alltags) (hash-table-values alltags)))
      (if hashPairs (progn
                      (setq sorted (sort hashPairs (lambda (a b) (> (cdr a) (cdr b)))))
                      (setq maxTagLength (apply `max (mapcar (lambda (x) (length (car x))) sorted)))
                      (setq maxTagAmnt (apply `max (mapcar (lambda (x) (cdr x)) sorted)))
                      ))
      (with-temp-buffer-window "*Tags*"
                               nil
                               nil
                               (mapc (lambda (x) (princ (format "%s\n" x)))
                                     (org-tagging/make-bar-chart sorted maxTagLength maxTagAmnt))
                               )
      )
    )

(defun org-tagging/tag-occurrences ()
    """ Count all occurrences of all tags and bar chart them """
    (interactive)
    ;;save eventually to a new buffer
    (let* ((tag-set (org-tagging/org-count-buffer-tags))
           (hashPairs (-zip (hash-table-keys tag-set) (hash-table-values tag-set)))
           (sorted (sort hashPairs (lambda (a b) (> (cdr a) (cdr b)))))
           (maxTagLength (apply `max (mapcar (lambda (x) (length (car x))) sorted)))
           (maxTagAmnt (apply `max (mapcar (lambda (x) (cdr x)) sorted)))
           (curr-buffer (buffer-name))
           )
      ;;print them all out

      (with-temp-buffer-window "*Tags*"
                               nil
                               nil
                               ;; Todo: Expand this func to group and add org headings
                               (mapc (lambda (x) (princ (format "%s\n" x)))
                                     (org-tagging/make-bar-chart sorted maxTagLength maxTagAmnt))
                               )

      (with-current-buffer "*Tags*"
        (org-mode)
        (let ((inhibit-read-only 't)
              (last_num "-1")
              (get_num_re ": \\([[:digit:]]+\\) +:"))
          ;;Loop over all lines
          (goto-char (point-min))
          (insert "* Tag Summary for: " curr-buffer "\n")
          (while (< (point) (point-max))
            (re-search-forward get_num_re nil 1)
            (if (string-equal last_num (match-string 1))
                (progn (beginning-of-line)
                       (insert "   ")
                       (forward-line))
              (progn (setq last_num (match-string 1))
                     (beginning-of-line)
                     (insert "** ")
                     (forward-line)))
            )))
      )
    )
