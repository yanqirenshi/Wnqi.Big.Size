(in-package :cl-user)
(defpackage wnqi-big-size-api.router.util
  (:nicknames #:wbs.router.util)
  (:use #:cl
        #:caveman2
        #:lack.middleware.validation
        #:wnqi-big-size-api.config
        #:wnqi-big-size-api.render)
  (:import-from :wbs.db
                #:ctx
                #:ctx-trx)
  (:export #:_parsed2plist
           #:with-user
           #:with-user-trx))
(in-package :wnqi-big-size-api.router.util)


(defun _parsed2plist (_parsed)
  (jojo:parse (car (car _parsed))))

(defun assert-session-user (user)
  (unless (or user (wbs.controller::session-user))
    (error (make-condition 'authentication-error))))

(define-condition authentication-error (simple-condition)
  ((message :initform "Faild authentication."
            :accessor message))
  (:report (lambda (condition stream)
             (format stream "~a" (message condition)))))

(defmacro with-user ((user) &body body)
  `(ctx
     (let ((,user (wbs.controller::session-user)))
       (handler-case
           (progn
             (assert-session-user ,user)
             (render-json (progn ,@body)))
         (authentication-error (e)
           (render-json (list :code 401
                              :message (format nil "~a" e))
                        :status 401))))))

(defmacro with-user-trx ((user) &body body)
  `(ctx-trx
     (let ((,user (wbs.controller::session-user)))
       (handler-case
           (progn
             (assert-session-user ,user)
             (render-json (progn ,@body)))
         (authentication-error (e)
           (render-json (list :code 401
                              :message (format nil "~a" e))
                        :status 401))))))
