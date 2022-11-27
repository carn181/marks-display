(in-package :marks-display)

(defun add-mark-to-file (mark)
  (let* ((mark-no (read-from-string (last-line *marks-data-file*)))
         (new-mark (format nil "~D ~D~%" (1+ mark-no) mark)))
    (alexandria:write-string-into-file new-mark *marks-data-file* :if-exists :append)))

(defun delete-last-line (file)
  (let ((nf (with-output-to-string (s)
                (with-open-file (in file :direction :input)
                  (loop
                    with last-line = (last-line file)
                    for line = (read-line in nil nil)
                    while line
                    unless (string= line last-line)
                      do (write-line line s)))
                s)))
    (alexandria:write-string-into-file nf file :if-exists :supersede)))

(defun last-line (file)
  (let* ((file (uiop:read-file-lines file)))
    (car (last file))))
