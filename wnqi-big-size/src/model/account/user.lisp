(in-package :wbs)

(defclass user ()
  ((user-code :col-type (:varchar 255)
              :initarg :user-code
              :accessor user-code)
   (name :col-type (:varchar 255)
         :initarg :name
         :accessor name)
   (description :col-type :text
                :initarg :description
                :accessor description
                :initform "")
   (created-by :col-type (:varchar 255)
               :initarg :created-by
               :accessor created-by)
   (updated-by :col-type (:varchar 255)
               :initarg :updated-by
               :accessor updated-by))
  (:table-name "acc.rs_user")
  (:metaclass mito:dao-table-class))

(defun get-user (&key code _iid)
  (cond (_iid (car (mito:select-dao 'user
                     (where (:= :_iid _iid)))))
        (code (mito:find-dao 'user :user-code code))))

(defun assert-not-exit-user-code (code)
  (let ((user (get-user :code code)))
    (when user
      (error "Already exit user. code=~a" user))))

(defun create-user (code name &optional (description "") (user-code "renshi"))
  (assert-not-exit-user-code code)
  (mito:create-dao 'user
                   :user-code code
                   :name name
                   :description description
                   :created-by user-code
                   :updated-by user-code))

(defun find-user ()
  (mito:select-dao 'user))
