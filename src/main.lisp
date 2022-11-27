(in-package :marks-display)

(defparameter *graph-image-file* "/home/ecm/.local/share/marks-display/marks.png")
(defparameter *marks-data-file* "/home/ecm/.local/share/marks-display/marks.txt")
(defparameter *is-running* nil)

(defun main ()
  (setf *is-running* t)
  (plot-marks "1000x800")
  (within-main-loop
    (let ((window (make-instance 'gtk-window
				 :type :toplevel
				 :title "Marks Display"
				 :default-width 1000))
          (vbox (make-instance 'gtk-box
                              :orientation :vertical
                              :spacing 3))
          (grid (make-instance 'gtk-grid
                               :column-homogeneous t
                               :column-spacing 4
                               :row-homogeneous t
                               :row-spacing 4))
          (graph (gtk-image-new-from-file *graph-image-file*))
          (refresh (gtk-button-new-with-label "Refresh"))
          (add (gtk-button-new-with-label "Add Marks"))
          (delete (gtk-button-new-with-label "Delete Mark")))
      (g-signal-connect window "destroy"
			(lambda (widget)
			  (declare (ignore widget))
			  (leave-gtk-main)
                          (setf *is-running* nil)))
      (g-signal-connect refresh "clicked"
                        (lambda (widget)
                          (declare (ignore widget))
                          (refresh-graph graph)))      
      (g-signal-connect add "clicked"
                        (lambda (widget)
                          (declare (ignore widget))
                          (add-marks graph)))
      (g-signal-connect delete "clicked"
                        (lambda (widget)
                          (declare (ignore widget))
                          (delete-last-line *marks-data-file*)
                          (refresh-graph graph)))

      (gtk-box-pack-start vbox graph)
      (gtk-box-pack-start vbox grid)

      (gtk-grid-attach grid refresh 0 0 1 2)
      (gtk-grid-attach grid add 1 0 3 1)
      (gtk-grid-attach grid delete 1 1 3 1)
      
      (gtk-container-add window vbox)
      (gtk-widget-show-all window)))
  (loop while *is-running*))

(defun refresh-graph (graph)
  (plot-marks "1000x800")
  (gtk-image-set-from-file graph *graph-image-file*))

(defun add-marks (graph)
  (let ((window (make-instance 'gtk-dialog
                               :title "Add Marks"
                               :has-seperator t))
        (vbox (make-instance 'gtk-box
                             :spacing 5
                             :orientation :vertical))
        (hbox (make-instance 'gtk-box
                             :spacing 5
                             :orientation :horizontal))
        (marks-input (make-instance 'gtk-entry
                                    :text ""
                                    :max-length 3))
        (add (gtk-button-new-with-label "Add"))
        (cancel (gtk-button-new-with-label "Cancel")))

    (gtk-window-move window 250 250)
    (setf (gtk-container-border-width (gtk-dialog-get-content-area window)) 12)
    
    (g-signal-connect window "destroy"
                      (lambda (widget)
                        (gtk-widget-destroy widget)
                        (refresh-graph graph)))
    (g-signal-connect add "clicked"
                      (lambda (widget)
                        (declare (ignore widget))
                        (let ((mark (gtk-entry-text marks-input)))
                          (if (not (string= mark ""))
                              (add-mark-to-file (parse-integer mark))))
                        (gtk-widget-destroy window)))

    (g-signal-connect cancel "clicked"
                      (lambda (widget)
                        (declare (ignore widget))
                        (gtk-widget-destroy window)))
    
    (gtk-box-pack-start vbox marks-input)
    (gtk-box-pack-start vbox hbox)

    (gtk-box-pack-start hbox add)
    (gtk-box-pack-start hbox cancel)

    (gtk-box-pack-start (gtk-dialog-get-content-area window) vbox)
    (gtk-widget-show-all window)))
