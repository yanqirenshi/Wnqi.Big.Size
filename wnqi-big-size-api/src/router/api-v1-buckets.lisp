(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-buckets
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
                #:ctx
                #:ctx-trx)
  (:export #:*api-v1-buckets*))
(in-package :wnqi-big-size-api.api-v1-buckets)

;;;
;;; router
;;;
(defclass <router> (<app>) ())

(defvar *api-v1-buckets* (make-instance '<router>))
(clear-routing-rules *api-v1-buckets*)

;;;
;;; routing
;;;
(defroute ("/:bucket-code/actions" :method :POST) (&key bucket-code _parsed)
  (with-user-trx (user)
    (wbs.ctl::move-action-2-bucket user
                                   (_parsed2plist _parsed)
                                   bucket-code)))
