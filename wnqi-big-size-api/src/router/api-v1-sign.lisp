(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-sign
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
  (:export #:*api-v1-sign*))
(in-package :wnqi-big-size-api.api-v1-sign)


;;;
;;; Router
;;;
(defclass <router> (<app>) ())
(defvar *api-v1-sign* (make-instance '<router>))
(clear-routing-rules *api-v1-sign*)

;;;
;;; Routing rules
;;;
(defroute ("/in" :method :POST) (&key _parsed)
  (ctx
    (render-json (wbs.ctl:sign-in (_parsed2plist _parsed)))))

(defroute ("/out" :method :POST) (&key _parsed)
  (ctx
    (render-json (wbs.ctl::sign-out (_parsed2plist _parsed)))))
