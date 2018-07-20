(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-wbs
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
  (:export #:*api-v1-wbs*))
(in-package :wnqi-big-size-api.api-v1-wbs)


;;;
;;; Router
;;;
(defclass <router> (<app>) ())
(defvar *api-v1-wbs* (make-instance '<router>))
(clear-routing-rules *api-v1-wbs*)

;;;
;;; Routing rules
;;;
(defroute ("/" :method :GET) ()
  (ctx
    (render-json (wbs:find-wbs))))
