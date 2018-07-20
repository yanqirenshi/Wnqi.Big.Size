(in-package :cl-user)
(defpackage wnqi-big-size-api.api-v1-pages
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
  (:export #:*api-v1-pages*))
(in-package :wnqi-big-size-api.api-v1-pages)


;;;
;;; router
;;;
(defclass <router> (<app>) ())

(defvar *api-v1-pages* (make-instance '<router>))
(clear-routing-rules *api-v1-pages*)


;;;
;;; routing
;;;
(defroute ("/cockpit" :method :GET) ()
  (with-user (user)
    (wbs.controller:page-cockpit user)))

(defroute ("/projects" :method :GET) ()
  (with-user (user)
    (wbs.controller::page-projects-list user)))

(defroute ("/projects/:project-code" :method :GET) (&key project-code)
  (with-user (user)
    (wbs.controller:page-projects-unit project-code)))

(defroute ("/wbs/:wbs-code" :method :GET) (&key wbs-code)
  (with-user (user)
    (wbs.controller::page-wbs wbs-code)))

(defroute ("/parsons" :method :GET) ()
  (with-user (user)
    (wbs.controller::page-parsons)))
