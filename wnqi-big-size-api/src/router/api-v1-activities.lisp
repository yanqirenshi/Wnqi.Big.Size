(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-activities
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
  (:export #:*api-v1-activities*))
(in-package :wnqi-big-size-api.api-v1-activities)


;;;
;;; Router
;;;
(defclass <router> (<app>) ())
(defvar *api-v1-activities* (make-instance '<router>))
(clear-routing-rules *api-v1-activities*)

;;;
;;; Routing rules
;;;
(defroute ("/activities" :method :GET) ()
  (with-user (user)
    (wbs:find-activity)))
