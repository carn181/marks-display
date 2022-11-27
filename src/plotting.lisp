(in-package :marks-display)

;; EXAMPLE (plot-marks "1000, 800")
(defun plot-marks (size)
  (with-plots (s :debug nil)
    (gp-setup :xlabel "Test No"
              :ylabel "Marks"
              :output (pathname *graph-image-file*)
              :terminal `(:png :size ,size)
              :key '(:bottom :right :font "Helvetica, 5")
              :grid 'nil)
    (plot (pathname *marks-data-file*) :title "Marks"
                                      :with '(:linespoint)
                                      :lc '(rgb "red"))
    s))
