(in-package :cl-user)
(defpackage wnqi-big-size.api.router
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:wnqi-big-size.api.render)
  (:export #:*api.v.1*))
(in-package :wnqi-big-size.api.router)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api.v.1* (make-instance '<router>))
(clear-routing-rules *api.v.1*)


;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  (render-json nil))


;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
