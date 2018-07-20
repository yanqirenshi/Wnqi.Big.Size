(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:wnqi-big-size-api.config
        #:wnqi-big-size-api.render)
  (:import-from #:wnqi-big-size-api.router.util
                #:_parsed2plist
                #:with-user
                #:with-user-trx)
  (:import-from #:wbs.db
                #:ctx)
  (:export #:*api-v1*))
(in-package :wnqi-big-size-api.api-v1)


;;;
;;; Router
;;;
(defclass <router> (<app>) ())
(defvar *api-v1* (make-instance '<router>))
(clear-routing-rules *api-v1*)

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")

;;;
;;; Routing rules
;;;
(defroute "/" ()
  "api-v1")
