(in-package :cl-user)
(defpackage wnqi-big-size.db
  (:nicknames :wbs.db)
  (:use #:cl)
  (:import-from :sxql
                #:yield)
  (:import-from :dbi
                #:prepare
                #:execute
                #:fetch-all)
  (:export #:ctx
           #:ctx-trx
           #:connect-db
           #:retrieve
           #:int2timestamp))
(in-package :wnqi-big-size.db)

(defvar *db-connection* nil)

(defun connect-db ()
  (setf *db-connection*
        (dbi:connect :mysql
                     :database-name "wbs"
                     :username "root"
                     :password "root")))

(defmacro ctx (&body body)
  `(let ((mito:*connection* *db-connection*))
     ,@body))

(defmacro ctx-trx (&body body)
  `(let ((mito:*connection* *db-connection*))
     (dbi:with-transaction *db-connection*
       ,@body)))

(defun retrieve (sxql &rest values)
  (fetch-all (apply #'execute
                    (prepare mito:*connection* (yield sxql))
                    values)))
