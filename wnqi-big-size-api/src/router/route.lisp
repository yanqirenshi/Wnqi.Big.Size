(in-package :cl-user)
(defpackage wnqi-big-size-api.router
  (:use :cl
        :caveman2
        :lack.middleware.validation
        :wnqi-big-size-api.config
        :wnqi-big-size-api.render)
  (:export #:*route*))
(in-package :wnqi-big-size-api.router)

;;;;;
;;;;; Router
;;;;;
(defclass <router> (<app>) ())
(defvar *route* (make-instance '<router>))
(clear-routing-rules *route*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
