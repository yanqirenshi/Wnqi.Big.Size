(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-actions
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
  (:export #:*api-v1-actions*))
(in-package :wnqi-big-size-api.api-v1-actions)

;;;
;;; router
;;;
(defclass <router> (<app>) ())

(defvar *api-v1-actions* (make-instance '<router>))
(clear-routing-rules *api-v1-actions*)

;;;
;;; routing
;;;
(defroute ("/" :method :GET) ()
  (wbs:find-action-start))

(defroute ("/" :method :POST) (&key _parsed)
  (with-user-trx (user)
    (wbs.ctl:create-action user (_parsed2plist _parsed))))

(defroute ("/:action-code" :method :GET) ()
  "api-v1 action get")

(defroute ("/:action-code" :method :PUT) ()
  "api-v1 action PUT")

(defroute ("/:action-code/start" :method :POST) (&key _parsed)
  (with-user-trx (user)
    (let ((action-code (cdr (assoc :action-code _parsed))))
      (wbs.ctl::start-action-action user action-code))))

(defroute ("/:action-code/stop" :method :POST) (&key _parsed)
  (with-user-trx (user)
    (let ((action-code (cdr (assoc :action-code _parsed))))
      (wbs.ctl::stop-action user action-code))))

(defroute ("/:action-code/archive" :method :POST) (&key _parsed)
  (with-user-trx (user)
    (wbs.ctl:archive-action user (cdr (assoc :action-code _parsed)))))
