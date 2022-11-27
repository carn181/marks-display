(asdf:defsystem marks-display
  :author "snuck"
  :license "GNU"
  :depends-on (:alexandria
               :cl-cffi-gtk
               :eazy-gnuplot)
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "file")
                 (:file "plotting")
                 (:file "main"))))
  :build-operation "program-op"
  :build-pathname #p"bin/marks-display"
  :entry-point "marks-display:main")
