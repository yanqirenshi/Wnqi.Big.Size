(in-package :wbs)

(defclass artifact ()
  ((artifact-code :primary-key t
                  :col-type :serial
                  :initarg :artifact-code
                  :initform nil
                  :accessor artifact-code)
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
  (:table-name "wbs.rs_artifact")
  (:metaclass mito:dao-table-class))

(defun get-artifact (&key code)
  (when code
    (mito:find-dao 'artifact :artifact-code code)))

(defun create-artifact (name &optional (description "") (user-code "renshi"))
  (mito:create-dao 'artifact
                   :name name
                   :description description
                   :created-by user-code
                   :updated-by user-code))
