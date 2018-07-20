(in-package :wbs)

(defclass parson ()
  ((parson-code :accessor parson-code
                :initarg :parson-code
                :initform nil
                :primary-key t
                :col-type :serial)
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
  (:table-name "org.rs_parson")
  (:metaclass mito:dao-table-class))

(defun get-parson (&key code)
  (when code
    (mito:find-dao 'parson :parson-code code)))

(defun create-parson (name &optional (description "") (user-code "renshi"))
  (mito:create-dao 'parson
                   :name name
                   :description description
                   :created-by user-code
                   :updated-by user-code))

(defun find-parson ()
  (mito:select-dao 'parson))

(defun get-user-parson-sql ()
  (select :*
    (from (:as :org.ts_user_parson :t1))
    (inner-join (:as :org.rs_parson :t2)
                :on (:= :t1.parson_code :t2.parson_code))
    (where (:= :t1.user_code :?))))

(defun %get-user-parson (rec)
  (record-2-dao rec 'parson
                :parson-code (getf rec :|parson_code|)
                :name (getf rec :|name|)
                :description (getf rec :|description|)
                :created-by (getf rec :|created_by|)
                :updated-by (getf rec :|updated_by|)))

(defun get-user-parson (user)
  (%get-user-parson
   (car (retrieve (get-user-parson-sql)
                  (user-code user)))))
