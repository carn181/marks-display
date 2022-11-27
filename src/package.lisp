(defpackage #:marks-display
  (:use :cl :eazy-gnuplot
        :gtk :gdk :gdk-pixbuf :gobject
        :glib :gio :pango :cairo)
  (:export #:main))
