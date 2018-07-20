(in-package :wbs)

(defclass user-parson ()
  ((user-code :col-type (:varchar 255)
              :accessor user-code
              :initarg :user-code)
   (parson-code :col-type :integer
                :accessor parson-code
                :initarg :parson-code
                :initform nil)
   (created-by :col-type (:varchar 255)
               :accessor created-by
               :initarg :created-by)
   (updated-by :col-type (:varchar 255)
               :accessor updated-by
               :initarg :updated-by))
  (:table-name "org.ts_user_parson")
  (:metaclass mito:dao-table-class))

(defun assert-aledy-exit-relation_create-user-parson (user parson)
  (assert
   (not (mito:find-dao 'user-parson
                       :user-code (user-code user)
                       :parson-code (parson-code parson)))))

(defun assert-parson-have-user (user parson)
  (assert
   (not (mito:select-dao 'user-parson
          (where (:and (:!= :user-code (user-code user))
                       (:= :parson-code (parson-code parson))))))))

(defun create-user-parson (user parson &key (user-code "renshi"))
  (assert-aledy-exit-relation_create-user-parson user parson)
  (assert-parson-have-user user parson)
  (mito:create-dao 'user-parson
                   :user-code (user-code user)
                   :parson-code (parson-code parson)
                   :created-by user-code
                   :updated-by user-code))
